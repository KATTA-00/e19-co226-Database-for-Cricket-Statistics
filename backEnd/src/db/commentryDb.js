const db = require("../../dbConfig/dbConfig");

const sql_commentry = `
SELECT OverNum, BallNumber, Commentary, RunsScored, Ball_ID, 1 AS innings FROM INNINGS1
UNION 
SELECT OverNum, BallNumber, Commentary, RunsScored, Ball_ID, 2 AS innings FROM INNINGS2 
limit 20
`;

const sql_wickets = `
SELECT Ball_ID, 1 AS innings FROM INNINGS1
NATURAL JOIN dismissalinnings1 
UNION 
SELECT Ball_ID, 2 AS innings FROM INNINGS2 
NATURAL JOIN dismissalinnings2
limit 20
`;

const sql_extra = `
SELECT Ball_ID, 1 AS innings, Type FROM INNINGS1
NATURAL JOIN extrainnings1 
UNION 
SELECT Ball_ID, 2 AS innings, Type FROM INNINGS2 
NATURAL JOIN extrainnings2
limit 20
`;


function getCommentry(res){

    db.query(sql_commentry, (err, comments) => {
            
        if (comments == undefined){
                console.log(err);
                res.status(404);
                return;
            }
            
            db.query(sql_wickets, (err, wicket) => {
                
                if (wicket == undefined){
                    console.log(err);
                    res.status(404);
                    return;
                }
                
                db.query(sql_extra, (err, extra) => {
                    
                    if (extra == undefined){
                        console.log(err);
                        res.status(404);
                        return;
                    }

                    let comment = comments.map(c => {
                        if (wicket.filter(w => (w.Ball_ID === c.Ball_ID) && (w.innings === c.innings)).length !== 0){
                            return {
                                ball:"W",
                                comment:(c.Commentary === null)?"":c.Commentary,
                                overNum:c.OverNum,
                                ballNumber:c.BallNumber,
                                ballId:c.Ball_ID,
                                innings:c.innings
                            };
                        }
                        return {
                            ball:c.RunsScored,
                            comment:(c.Commentary === null)?"":c.Commentary,
                            overNum:c.OverNum,
                            ballNumber:c.BallNumber,
                            ballId:c.Ball_ID,
                            innings:c.innings
                        };
                    });

                    comment.forEach(c => {
                        extra.forEach(w => {
                            if ((w.Ball_ID === c.ballId) && (w.innings === c.innings)){
                                switch(w.Type){
                                    case "wides":
                                        c.ball = "Wd";
                                        break;
                                    
                                    case "noBalls":
                                        c.ball = "N";
                                        break;

                                    case "legByes":
                                        c.ball = "Lb";
                                        break;

                                    case "byes":
                                        c.ball = "B";
                                        break;
                                    
                                    default:
                                        c.ball = c.ball;
                                    
                                }
                            }
                        });
                    });
        
                    res.status(200).json(comment);
        
                });
    
            });

    });
}

module.exports = getCommentry;
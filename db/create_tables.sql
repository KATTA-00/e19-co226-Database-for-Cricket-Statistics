CREATE TABLE PLAYER(
    PlayerID INT NOT NULL PRIMARY KEY,
    PlayerName VARCHAR(40),
    PlayerType VARCHAR(15),
    DateofBirth date
);

CREATE TABLE TEAM(
    TeamID INT NOT NULL PRIMARY key,
    TeamName VARCHAR(20),
    Country VARCHAR(20),
    Coach VARCHAR(20),
    CaptainID INT,
    CONSTRAINT fk_captain FOREIGN KEY(CaptainID)  
    REFERENCES PLAYER(PlayerID)  
    ON DELETE SET NULL  
    ON UPDATE CASCADE);

CREATE TABLE TEAMPLAYERS(
    PlayerID INT NOT NULL PRIMARY KEY,
    TeamID INT,
    CONSTRAINT fk_teamID FOREIGN KEY (TeamID)
    REFERENCES TEAM(TeamID)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
    CONSTRAINT fk_playerID FOREIGN KEY (PlayerID)
    REFERENCES PLAYER(PlayerID)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE CURRENTMATCH(
    Team1_ID INT,
    Team2_ID INT,
    Date DATE,
    Time TIME,
    Venue VARCHAR(30),
    Toss INT,
    MatchName VARCHAR(50),
    TossIsBatting BOOLEAN,
    MatchType INT,
    PRIMARY KEY (Team1_ID, Team2_ID, Date),
    CONSTRAINT fk_team1 FOREIGN KEY (Team1_ID)
    REFERENCES TEAM(TeamID)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    CONSTRAINT fk_team2 FOREIGN KEY (Team2_ID)
    REFERENCES TEAM(TeamID)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    CONSTRAINT fk_toss FOREIGN KEY (Toss)
    REFERENCES TEAM(TeamID)
    ON DELETE SET NULL
    ON UPDATE CASCADE 
    );

CREATE TABLE INNINGS1(
    Ball_ID INT NOT NULL PRIMARY KEY,
    OverNum INT,
    BallNumber INT,
    RunsScored INT,
    OnStrikeID INT,
    NonStrikeID INT,
    CurrentBowlerID INT,
    Commentary TEXT,
    CONSTRAINT fk_onstrike FOREIGN KEY (OnStrikeID)
    REFERENCES PLAYER(PlayerID)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    CONSTRAINT fk_nonStrike FOREIGN KEY (NonStrikeID)
    REFERENCES PLAYER(PlayerID)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    CONSTRAINT fk_currentBowler FOREIGN KEY (CurrentBowlerID)
    REFERENCES PLAYER(PlayerID)
    ON DELETE CASCADE
    ON UPDATE CASCADE 
);

CREATE TABLE INNINGS2(
    Ball_ID INT NOT NULL PRIMARY KEY,
    OverNum INT,
    BallNumber INT,
    RunsScored INT,
    OnStrikeID INT,
    NonStrikeID INT,
    CurrentBowlerID INT,
    Commentary TEXT,
    CONSTRAINT fk_onstrike2nd FOREIGN KEY (OnStrikeID)
    REFERENCES PLAYER(PlayerID)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    CONSTRAINT fk_nonStrike2nd FOREIGN KEY (NonStrikeID)
    REFERENCES PLAYER(PlayerID)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    CONSTRAINT fk_currentBowler2nd FOREIGN KEY (CurrentBowlerID)
    REFERENCES PLAYER(PlayerID)
    ON DELETE CASCADE
    ON UPDATE CASCADE 
);

CREATE TABLE EXTRAINNINGS1(
    Ball_ID INT NOT NULL PRIMARY KEY,
    Type VARCHAR(15),
    ExtraRuns INT,
    CONSTRAINT fk_ballidExtra1 FOREIGN KEY (Ball_ID)
    REFERENCES INNINGS1(Ball_ID)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE EXTRAINNINGS2(
    Ball_ID INT NOT NULL PRIMARY KEY,
    Type VARCHAR(15),
    ExtraRuns INT,
    CONSTRAINT fk_ballidExtra2 FOREIGN KEY (Ball_ID)
    REFERENCES INNINGS2(Ball_ID)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE DISMISSALINNINGS1(
    Ball_ID INT NOT NULL PRIMARY KEY,
    DismissType VARCHAR(15),
    CaughtBy INT,
    FieldedBy INT,
    Dismissed INT,
    CONSTRAINT fk_caughtby1 FOREIGN KEY (CaughtBy)
    REFERENCES PLAYER(PlayerID)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    CONSTRAINT fk_fieldedby1 FOREIGN KEY (FieldedBy)
    REFERENCES PLAYER(PlayerID)
    ON DELETE CASCADE
    ON UPDATE CASCADE, 
    CONSTRAINT fk_dismissed1 FOREIGN KEY (Dismissed)
    REFERENCES PLAYER(PlayerID)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    CONSTRAINT fk_ballidDismiss1 FOREIGN KEY (Ball_ID)
    REFERENCES INNINGS1(Ball_ID)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE DISMISSALINNINGS2(
    Ball_ID INT NOT NULL PRIMARY KEY,
    DismissType VARCHAR(15),
    CaughtBy INT,
    FieldedBy INT,
    Dismissed INT,
    CONSTRAINT fk_caughtby2 FOREIGN KEY (CaughtBy)
    REFERENCES PLAYER(PlayerID)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    CONSTRAINT fk_fieldedby2 FOREIGN KEY (FieldedBy)
    REFERENCES PLAYER(PlayerID)
    ON DELETE CASCADE
    ON UPDATE CASCADE, 
    CONSTRAINT fk_dismissed2 FOREIGN KEY (Dismissed)
    REFERENCES PLAYER(PlayerID)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    CONSTRAINT fk_ballidDismiss2 FOREIGN KEY (Ball_ID)
    REFERENCES INNINGS2(Ball_ID)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

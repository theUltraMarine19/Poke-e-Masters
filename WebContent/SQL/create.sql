-- CREATE TABLE City
-- (
--       CityID VARCHAR(4),
--       BaseLevel INT DEFAULT 0,
--       CityName VARCHAR(15) NOT NULL,
--       PokeShopLocX NUMERIC(2,0) DEFAULT 50,
--       PokeShopLocY NUMERIC(2,0) DEFAULT 50,
--       PRIMARY KEY (CityID)
-- );

CREATE TABLE Attack
(
      AttackID VARCHAR(4),
      Name VARCHAR(50) NOT NULL,
      Power INT DEFAULT 0,
      Accuracy INT DEFAULT 0,
      PP INT DEFAULT 0,
      Type VARCHAR(15) NOT NULL,
      PRIMARY KEY (AttackID)
);

CREATE TABLE ArtificialPlayer
(
      APid VARCHAR(8),
      APname VARCHAR(15) NOT NULL,
      APcity VARCHAR(20),
      APavatar INT DEFAULT 0,
      Badge INT DEFAULT 0, 
      PRIMARY KEY (APid)
);

CREATE TABLE Item
(
      ItemID VARCHAR(8),
      Name VARCHAR(30) NOT NULL,
      Cost INT DEFAULT 0,
      Effect VARCHAR(10) DEFAULT NULL,
      EffectValue INT DEFAULT 0,
      PRIMARY KEY (ItemID)
);

-- CREATE TABLE PokemonType
-- (
--       TypeID VARCHAR(4),
--       Name VARCHAR(10) NOT NULL,
--       Description VARCHAR(100) NOT NULL,
--       PRIMARY KEY (TypeID)
-- );

CREATE TABLE Player
(
      Name VARCHAR(15) NOT NULL,
      NickName VARCHAR(15) NOT NULL,
      ID VARCHAR(8),
      Password VARCHAR(15) NOT NULL,
      Email VARCHAR(30) NOT NULL UNIQUE,
      Experience INT DEFAULT 0,
      Money INT DEFAULT 1000,
      email_verified VARCHAR(10),
      avatar_chosen INT DEFAULT 0,
      starter_pokemon INT DEFAULT 0,
      PRIMARY KEY (ID)
);

-- CREATE TABLE Gym
-- (
--       GymID VARCHAR(4),
--       BadgeName VARCHAR(15) NOT NULL,
--       LocationX NUMERIC(2,0) DEFAULT 50,
--       LocationY NUMERIC(2,0) DEFAULT 50,
--       CityID VARCHAR(4),
--       PRIMARY KEY (GymID),
--       FOREIGN KEY (CityID) REFERENCES City(CityID) ON DELETE CASCADE
-- );

CREATE TABLE HasItem
(
      Count INT DEFAULT 0,
      ID VARCHAR(8),
      ItemID VARCHAR(8),
      PRIMARY KEY (ID, ItemID),
      FOREIGN KEY (ID) REFERENCES Player(ID) ON DELETE CASCADE,
      FOREIGN KEY (ItemID) REFERENCES Item(ItemID) ON DELETE CASCADE
);

-- CREATE TABLE HasWonBadge
-- (
--       ID VARCHAR(8),
--       Badge INT,
--       PRIMARY KEY (ID, Badge),
--       FOREIGN KEY (ID) REFERENCES Player(ID) ON DELETE CASCADE
-- );

-- CREATE TABLE GymBattleHist
-- (
--       Result VARCHAR(4) NOT NULL,
--       BattleTime TIMESTAMP NOT NULL,
--       BattleID VARCHAR(15),
--       APid VARCHAR(8),
--       ID VARCHAR(8),
--       PRIMARY KEY (BattleID),
--       FOREIGN KEY (APid) REFERENCES AritificialPlayer(APid) ON DELETE CASCADE,
--       FOREIGN KEY (ID) REFERENCES Player(ID) ON DELETE CASCADE
-- );

CREATE TABLE TypeEffect
(
      AttackerType VARCHAR(10),
      ReceiverType VARCHAR(10),
      MultFactor INT DEFAULT 100,
      PRIMARY KEY (AttackerType, ReceiverType)
);

CREATE TABLE Pokemon
(
      PID VARCHAR(4),
      Name VARCHAR(30) NOT NULL,
      BaseHP INT NOT NULL,
      BaseAttack INT NOT NULL,
      BaseSpeed INT NOT NULL,
      BaseDefence INT NOT NULL,
      MoveList VARCHAR(100) DEFAULT '0',
      TypeList VARCHAR(50) NOT NULL,
      BaseLevel INT DEFAULT 5,
      MinEvolveLevel INT,
      EvolveIntoID VARCHAR(4),
      EvolveTrigger VARCHAR(20),
      BaseExp INT DEFAULT 10,
      PRIMARY KEY (PID)
);

CREATE TABLE PlayerPokemon
(
      Level INT NOT NULL,
      UID VARCHAR(4),
      CurrentHP INT NOT NULL,
      Experience INT NOT NULL,
      TeamPosition INT NOT NULL,
      ID VARCHAR(8),
      PID VARCHAR(4),
      IV INT DEFAULT 0,
      EV INT DEFAULT 50,
      PRIMARY KEY (UID, ID),
      FOREIGN KEY (ID) REFERENCES Player(ID) ON DELETE CASCADE,
      FOREIGN KEY (PID) REFERENCES Pokemon(PID) ON DELETE CASCADE
);

CREATE TABLE APPlayerPokemon
(
      ID VARCHAR(8),
      PID VARCHAR(4),
      Level INT NOT NULL,
      UID VARCHAR(4),
      CurrentHP INT NOT NULL,
      IV INT DEFAULT 0,
      EV INT DEFAULT 50,
      PRIMARY KEY (UID, ID),
      FOREIGN KEY (ID) REFERENCES ArtificialPlayer(APid) ON DELETE CASCADE,
      FOREIGN KEY (PID) REFERENCES Pokemon(PID) ON DELETE CASCADE
);

CREATE TABLE HasAttack
(
      PID VARCHAR(4),
      AttackID VARCHAR(4),
      LevelLearnedAt INT,
      PRIMARY KEY (PID, AttackID),
      FOREIGN KEY (PID) REFERENCES Pokemon(PID) ON DELETE CASCADE,
      FOREIGN KEY (AttackID) REFERENCES Attack(AttackID) ON DELETE CASCADE
);

CREATE TABLE WildPokemon
(
      PID VARCHAR(4),
      WildID VARCHAR(4),
      Level INT NOT NULL,
      CurrentHP INT NOT NULL,
      IV INT DEFAULT 0,
      EV INT DEFAULT 50,  
      PRIMARY KEY(WildID),    
      FOREIGN KEY (PID) REFERENCES Pokemon(PID) ON DELETE CASCADE     
);

CREATE TABLE WildPokemonMoves
(
      WildID VARCHAR(4),
      AttackID VARCHAR(4),
      PP INT,
      PRIMARY KEY(WildID,AttackID),
      FOREIGN KEY(WildID) REFERENCES WildPokemon(WildID) ON DELETE CASCADE,
      FOREIGN KEY(AttackID) REFERENCES Attack(AttackID) ON DELETE CASCADE
);

-- CREATE TABLE APPokemon
-- (
--       Level INT NOT NULL,
--       PID VARCHAR(4),
--       APid VARCHAR(8),
--       PRIMARY KEY (PID, APid),
--       FOREIGN KEY (PID) REFERENCES Pokemon(PID) ON DELETE CASCADE,
--       FOREIGN KEY (APid) REFERENCES AritificialPlayer(APid) ON DELETE CASCADE
-- );

-- CREATE TABLE WildBattleHist
-- (
--       Result VARCHAR(4) NOT NULL,
--       Level INT NOT NULL,
--       BattleTime TIMESTAMP NOT NULL,
--       BattleID VARCHAR(20),
--       ID VARCHAR(8),
--       PID VARCHAR(4),
--       PRIMARY KEY (BattleID),
--       FOREIGN KEY (ID) REFERENCES Player(ID) ON DELETE CASCADE,
--       FOREIGN KEY (PID) REFERENCES Pokemon(PID) ON DELETE CASCADE
-- );

-- CREATE TABLE CurrentBattleList
-- (
--       Result VARCHAR(4) NOT NULL,
--       WinID VARCHAR(8) ,
--       BattleTime TIMESTAMP NOT NULL,
--       BattleID VARCHAR(20),
--       ID1 VARCHAR(8),
--       ID2 VARCHAR(8),
--       PRIMARY KEY (BattleID),
--       FOREIGN KEY (ID) REFERENCES Player(ID) ON DELETE CASCADE,
--       FOREIGN KEY (PID) REFERENCES Pokemon(PID) ON DELETE CASCADE
-- );

CREATE TABLE PlayerPokemonMoves
(
      ID VARCHAR(8),
      UID VARCHAR(4),
      AttackID VARCHAR(4),
      PP INT,
      PRIMARY KEY(ID,UID,AttackID),
      FOREIGN KEY(ID,UID) REFERENCES PlayerPokemon(ID,UID) ON DELETE CASCADE,
      FOREIGN KEY(AttackID) REFERENCES Attack(AttackID) ON DELETE CASCADE
);

CREATE TABLE APPlayerPokemonMoves
(
      ID VARCHAR(8),
      UID VARCHAR(4),
      AttackID VARCHAR(4),
      PP INT,
      PRIMARY KEY(ID,UID,AttackID),
      FOREIGN KEY(ID,UID) REFERENCES APPlayerPokemon(ID,UID) ON DELETE CASCADE,
      FOREIGN KEY(AttackID) REFERENCES Attack(AttackID) ON DELETE CASCADE
);

CREATE TABLE MessageExchange
(
      FromID VARCHAR(8),
      ToID VARCHAR(8),      
      MessageType VARCHAR(20),
      Message VARCHAR(100),
      FOREIGN KEY(FromID) REFERENCES Player(ID) ON DELETE CASCADE,
      FOREIGN KEY(ToID) REFERENCES Player(ID) ON DELETE CASCADE
);

CREATE SEQUENCE UserID START 1;

CREATE SEQUENCE WildBattleHistID START 1;

CREATE SEQUENCE GymBattleHistID START 1;

CREATE SEQUENCE UserPokemonID START 1;

CREATE SEQUENCE WildPokemonID START 1;

CREATE SEQUENCE CityID START 1;

CREATE SEQUENCE AttackID START 1;

CREATE SEQUENCE ItemID START 1;

CREATE SEQUENCE ApID START 1;

CREATE SEQUENCE GymID START 1;

-- CREATE SEQUENCE TypeID START 1;

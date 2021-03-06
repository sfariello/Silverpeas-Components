CREATE TABLE UniqueId (
  maxId bigint generated by default as identity,
  tableName varchar(100) NOT NULL,
  primary key(maxId)
);


CREATE TABLE sc_kmelia_search
(
  id bigint generated by default as identity,
	instanceId character varying(50) NOT NULL,
	topicId int NOT NULL,
	userId int NOT NULL,
	searchDate datetime NOT NULL,
	language character varying(100),
	query character varying(255),
	PRIMARY KEY (id)
);

CREATE INDEX IND_sc_kmelia_search
ON sc_kmelia_search (id);

CREATE TABLE SB_Statistic_History
(
    dateStat    varchar(10)   NOT NULL,
    heureStat   varchar(10)   NOT NULL,
    userId    varchar(100)    NOT NULL,
    objectId    int     NOT NULL,
    componentId   varchar(50)   NOT NULL,
    actionType    int     NOT NULL,
    objectType    varchar(50)         NOT NULL    
);

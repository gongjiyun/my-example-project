DROP TABLE IF EXISTS TB_PERSONS;
CREATE TABLE TB_PERSONS
(
  ID        VARCHAR(32) NOT NULL,
  NAME      VARCHAR(120) NOT NULL,
  GENDER    VARCHAR(1) NULL,
  TEL	    VARCHAR(20) NULL,
  BIRTH_DT  DATETIME	NULL,
  EMAIL     VARCHAR(50) NULL
);

DROP TABLE IF EXISTS TB_USERS;
CREATE TABLE TB_USERS
(
  ID        VARCHAR(32) NOT NULL,
  LOGIN_ID  VARCHAR(20) NOT NULL,
  PASSWORD  VARCHAR(32) NOT NULL
);

DROP TABLE IF EXISTS TB_LOGIN_LOG;
CREATE TABLE TB_LOGIN_LOG
(
  ID        VARCHAR(32) NOT NULL,
  LOGIN_ID  VARCHAR(20) NOT NULL,
  LOGIN_DT  DATETIME	NOT NULL,
  LOGIN_IP  VARCHAR(32)	NOT NULL
);

INSERT INTO TB_USERS(ID, LOGIN_ID, PASSWORD) VALUES('1', 'JIYUN', 'PASSWORD1');

COMMIT;
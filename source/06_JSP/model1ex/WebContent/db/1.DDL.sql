-- DROP & CREATE SEQUENCE, TABLE, DUMMY DATA?
DROP TABLE FILEBOARD;
DROP TABLE CUSTOMER;
DROP TABLE BOOK;
DROP SEQUENCE FILEBOARD_SEQ;
DROP SEQUENCE CUSTOMER_SEQ;
DROP SEQUENCE BOOK_SEQ;

CREATE TABLE BOOK(
  bID    NUMBER(7) PRIMARY KEY,
  bTITLE VARCHAR2(100) NOT NULL, -- 책이름
  bPRICE NUMBER(6)     NOT NULL, -- 책가격
  bIMAGE1 VARCHAR2(100) NOT NULL, -- 책 대표 이미지
  bIMAGE2 VARCHAR2(100) NOT NULL, -- 책 부가 이미지
  bCONTENT VARCHAR2(4000), -- 책설명(4000초과시 CLOB)
  bDISCOUNT NUMBER(3) NOT NULL,   -- 할인율
  bRDATE    DATE DEFAULT SYSDATE
);
CREATE SEQUENCE BOOK_SEQ MAXVALUE 9999999 NOCACHE NOCYCLE;

CREATE TABLE CUSTOMER(
CID VARCHAR2(50) NOT NULL PRIMARY KEY,
CPW VARCHAR2(50) NOT NULL,
CNAME VARCHAR2(50) NOT NULL,
CTEL VARCHAR2(50),
CEMAIL VARCHAR2(50),
CADDRESS VARCHAR2(50),
CBIRTH DATE,
CGENDER VARCHAR2(1),
CRDATE DATE DEFAULT SYSDATE
);

SELECT * FROM CUSTOMER;


CREATE TABLE FILEBOARD(
FID VARCHAR2(50) PRIMARY KEY,
CID VARCHAR2 (50) REFERENCES CUSTOMER(CID) NOT NULL,
FTITLE VARCHAR2(100) NOT NULL,
FCONTENT VARCHAR2 (1000), 
FILENAME VARCHAR2(100),
FHIT NUMBER(5) DEFAULT 0 NOT NULL,
FPW VARCHAR2(50) NOT NULL,
FGROUP NUMBER(6) NOT NULL,
FSTEP NUMBER(2) NOT NULL,
FINDENT NUMBER(2) NOT NULL,
FIP VARCHAR2(50) NOT NULL,
FRDATE DATE DEFAULT SYSDATE NOT NULL
);

CREATE SEQUENCE FILEBOARD_SEQ MAXVALUE 999999 NOCACHE NOCYCLE;
SELECT * FROM FILEBOARD;

INSERT INTO FILEBOARD (FID,CID,FTITLE,FCONTENT,FILENAME,FPW,FGROUP,FSTEP,FINDENT,FIP,FRDATE)
VALUES (FILEBOARD_SEQ.NEXTVAL, 'aaa1','저것이자바다','저것이자바다의설명','111.jpg','111',FILEBOARD_SEQ.CURRVAL,0,0,'127.0.0.1',SYSDATE);

INSERT INTO FILEBOARD (FID,CID,FTITLE,FCONTENT,FILENAME,FPW,FGROUP,FSTEP,FINDENT,FIP,FRDATE)
VALUES (FILEBOARD_SEQ.NEXTVAL, 'aaa1','그것이자바다','그것이자바다의설명','112.jpg','111',FILEBOARD_SEQ.CURRVAL,0,0,'127.0.0.1',SYSDATE);

INSERT INTO FILEBOARD (FID,CID,FTITLE,FCONTENT,FILENAME,FPW,FGROUP,FSTEP,FINDENT,FIP,FRDATE)
VALUES (FILEBOARD_SEQ.NEXTVAL, 'aaa1','요것이자바다','요것이자바다의설명','113.jpg','111',FILEBOARD_SEQ.CURRVAL,0,0,'127.0.0.1',SYSDATE);


update BOOK set BIMAGE1 = '1191.jpg' where bid = '24';
commit;
SELECT * FROM BOOK;
select * from fileboard;
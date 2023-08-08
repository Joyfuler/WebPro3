-- 테이블 및 시퀀스 우선삭제 (customer -> cus_level)
DROP TABLE CUSTOMER;
DROP TABLE CUS_LEVEL;
DROP SEQUENCE CUSTOMER_CID_SEQ;

-- 테이블 생성, 시퀀스 생성
CREATE TABLE CUS_LEVEL (
LEVELNO NUMBER(1) PRIMARY KEY,
LEVELNAME VARCHAR2(20) NOT NULL,
LOW NUMBER(9) NOT NULL,
HIGH NUMBER(9) NOT NULL
);

CREATE SEQUENCE CUSTOMER_CID_SEQ INCREMENT BY 1 START WITH 1 MAXVALUE 999999999 NOCACHE NOCYCLE;
CREATE TABLE CUSTOMER (
CID NUMBER(9) PRIMARY KEY,
CTEL VARCHAR2 (30) UNIQUE,
CNAME VARCHAR2 (30) NOT NULL,
CPOINT NUMBER (6) DEFAULT 1000 NOT NULL CHECK (CPOINT >=0),
CAMOUNT NUMBER(9) DEFAULT 0 NOT NULL,
LEVELNO NUMBER(1) DEFAULT 1 NOT NULL,
CMEMO VARCHAR2 (4000),
FOREIGN KEY (LEVELNO) REFERENCES CUS_LEVEL (LEVELNO)
);

-- 더미데이터입력
INSERT INTO CUS_LEVEL VALUES (1, 'NORMAL', 0, 999999);
INSERT INTO CUS_LEVEL VALUES (2, 'SILVER', 1000000, 1999999);
INSERT INTO CUS_LEVEL VALUES (3, 'GOLD', 2000000, 2999999);
INSERT INTO CUS_LEVEL VALUES (4, 'VIP', 3000000, 3999999);
INSERT INTO CUS_LEVEL VALUES (5, 'VVIP', 4000000, 999999999);



DROP SEQUENCE CUSTOMER_CID_SEQ;
SELECT * FROM CUS_LEVEL;
INSERT INTO CUSTOMER (CID, CTEL, CNAME) VALUES (CUSTOMER_CID_SEQ.NEXTVAL, '010-9999-9999', '홍길동');
SELECT * FROM CUSTOMER;
INSERT INTO CUSTOMER VALUES (CUSTOMER_CID_SEQ.NEXTVAL, '010-8888-8888', '김길동',0,4000000,5,NULL);
INSERT INTO CUSTOMER VALUES (CUSTOMER_CID_SEQ.NEXTVAL, '010-7777-7777', '신길동', 0, 1500000, 2, '진상고객');
INSERT INTO CUSTOMER VALUES (CUSTOMER_CID_SEQ.NEXTVAL, '010-8888-9999', '김길동', 1000,4000000,5,NULL);

COMMIT;
select customer.*, (high-camount) ato from customer, cus_level where camount between low and high;

-- 더미데이터입력 (cus_level -> customer)

-- 1) 회원가입
-- public int insertCustomer (String ctel, String cname)
-- public int insertCustomer (String customerDto dto)
INSERT INTO CUSTOMER (CID, CTEL, CNAME)
VALUES (CUSTOMER_CID_SEQ.NEXTVAL, '010-6666-6666', '유길동');
ROLLBACK;

-- 2) 폰4자리검색 (SELECTTEL을 받아 CID,CNAME,CPOINT,CAMOUNT,LEVELNAME,FORLEVELUP)
SELECT CID,CNAME,CPOINT,CAMOUNT,LEVELNAME, (HIGH+1)-CAMOUNT FORLEVELUP FROM CUSTOMER C, CUS_LEVEL L WHERE C.LEVELNO=L.LEVELNO AND CTEL LIKE '%'||
'9999';

SELECT CID,CTEL,CNAME,CPOINT,CAMOUNT,LEVELNAME,
(SELECT HIGH+1-CAMOUNT FROM CUSTOMER WHERE LEVELNO !=5 AND CID=C.CID) FORLEVELUP FROM CUSTOMER C, CUS_LEVEL L
WHERE C.LEVELNO=L.LEVELNO AND CTEL LIKE '%9999' ORDER BY CAMOUNT DESC;
-- CID가 밖에 있는 CID와 동일한 경우에만 출력. (한줄만 출력하도록 함)


-- 3) 물품구입 (CID, PRICE를 받아, 구매액의 5%를 CPOINT 누적, 구매액을 전부 CAMOUNT 누적, 바꾼 CAMOUNT에 따라 LEVELNO 수정)
-- public int buy (int cid, int price)
-- 1단계: cpoint와 cmount 누적..
UPDATE CUSTOMER SET CPOINT = CPOINT + (1000000 * 0.05), CAMOUNT = CAMOUNT + 1000000 WHERE CID= 1;
ROLLBACK;

-- 2단계: LEVELNO를 업데이트. BETWEEN LOW AND HIGH를 서브쿼리로 사용
UPDATE CUSTOMER SET LEVELNO = (SELECT L.LEVELNO 
FROM CUSTOMER C, CUS_LEVEL L WHERE CAMOUNT BETWEEN LOW AND HIGH AND CID=1) WHERE CID = 1;

-- 3단계: (1+2)단계 합체한 쿼리
UPDATE CUSTOMER 
SET CPOINT = CPOINT+(1000000 * 0.05), CAMOUNT = CAMOUNT + 1000000, LEVELNO = (SELECT L.LEVELNO 
FROM CUSTOMER C, CUS_LEVEL L WHERE CAMOUNT+1000000 BETWEEN LOW AND HIGH AND CID=1) WHERE CID = 1;
-- 위 UPDATE에서 CAMOUNT가 즉각 LEVEL에 반영되지 않으므로, 바뀌는 LEVEL (CUS_LEVEL) 값을 SELECT하고 WHERE절의 CAMOUNT에 UPDATE된 값을 함께 넣어줌.
SELECT * FROM CUSTOMER WHERE CID=4;
ROLLBACK;
commit;
-- 3-1) 물품구매 후 고객정보를 출력 (SELECT) (CID,CTEL,CNAME,CPOINT,CAMMOUNT,LEVELNAME, FORLEVELUP) --> 1명만 출력되므로 string?
-- public CustomerDto getCustomer (int cid)
SELECT CID, CTEL, CNAME, CPOINT, CAMOUNT, LEVELNAME, (SELECT (HIGH+1)-CAMOUNT FROM CUSTOMER WHERE LEVELNO != 5 AND CID = C.CID) FORLEVELUP
FROM CUSTOMER C, CUS_LEVEL L WHERE C.LEVELNO=L.LEVELNO AND CID=1;


--4) 고객등급별출력.. (NORMAL,SILVER,VIP,VVIP 입력받아 해당레벨결과출력)
-- public ArrayList<String> getLevelNames()
-- public ArrayList<CustomerDto> levelNameGetcustomers (String levelName)
SELECT LEVELNAME FROM CUS_LEVEL; -- ARRAYLIST STRING으로 출력하여 입력하게함.
SELECT CID, CTEL, CNAME, CPOINT, CAMOUNT, LEVELNAME, (SELECT (HIGH+1)-CAMOUNT FROM CUSTOMER WHERE LEVELNO != 5 AND CID = C.CID) FORLEVELUP
FROM CUSTOMER C, CUS_LEVEL L WHERE C.LEVELNO=L.LEVELNO AND LEVELNAME=UPPER('NORMAL') ORDER BY CAMOUNT DESC, CID;


--5) 전체출력
--public ArrayList<CustomerDto> Getcustomers()
SELECT CID, CTEL, CNAME, CPOINT, CAMOUNT, LEVELNAME, (SELECT (HIGH+1)-CAMOUNT FROM CUSTOMER WHERE LEVELNO != 5 AND CID = C.CID) FORLEVELUP
FROM CUSTOMER C, CUS_LEVEL L WHERE C.LEVELNO=L.LEVELNO ORDER BY CAMOUNT DESC, CID;

select * from customer;
--회원탈퇴: ctel을 받아 delete함. result가 0이라면 삭제안됨. 1이면 삭제됨
-- public int deleteCustomer(String ctel)
DELETE FROM CUSTOMER WHERE CTEL= '010-6666-6666';
SELECT * FROM CUSTOMER;


SELECT CID, CTEL, CNAME, CPOINT, CAMOUNT, LEVELNAME, (SELECT (HIGH+1)-CAMOUNT FROM CUSTOMER WHERE LEVELNO!= 5 AND CID = C.CID) FORLEVELUP
				 FROM CUSTOMER C, CUS_LEVEL L WHERE C.LEVELNO=L.LEVELNO AND CID = 1;
                 
                 
               SELECT CID, CTEL, CNAME, CPOINT, CAMOUNT, LEVELNAME, (SELECT (HIGH+1)-CAMOUNT FROM CUSTOMER WHERE LEVELNO != 5 AND CID = C.CID) FORLEVELUP
				FROM CUSTOMER C, CUS_LEVEL L WHERE C.LEVELNO=L.LEVELNO AND LEVELNAME=UPPER('silver') ORDER BY CAMOUNT DESC, CID;
-- CUSTOMERDAO 들어갈 QUERY
-- 1. 회원가입 (int)
INSERT INTO CUSTOMER (CID,CPW,CNAME,CTEL,CEMAIL,CADDRESS,CBIRTH,CGENDER)
VALUES ('ccc10','222','장길동','010-6666-5555','cc@aa.com','부산서구','88-01-01','m');

-- 2. 로그인
SELECT * FROM CUSTOMER WHERE CID = 'aaa1' AND CPW = '111';

-- 3. 회원리스트보기 (페이징, ARRAYLIST)
SELECT * FROM (SELECT ROWNUM RN, C.* FROM (SELECT * FROM CUSTOMER) C) WHERE RN BETWEEN 2 AND 4;

-- 2. 회원의 CID로 DTO 가져오기
SELECT * FROM CUSTOMER WHERE CID = 'aaa1';






-- BOOKDAO 들어갈 QUERY
-- 1. 책등록
INSERT INTO BOOK (bID, bTITLE, bPRICE, bIMAGE1, bIMAGE2, bCONTENT, bDISCOUNT)
    VALUES (BOOK_SEQ.NEXTVAL, 'HTML5',2000,'114.jpg','noImg.png','좋다 ',10);
-- 2. 책목록(PAGING 없이)
SELECT * FROM BOOK ORDER BY BRDATE DESC;
-- 2. 책목록(PAGING처리 : TOP-N)
SELECT ROWNUM RN, A.*
  FROM (SELECT * FROM BOOK ORDER BY BRDATE DESC) A; -- TOP-N구문의 INLINE VIEW에 들어갈 QUERY
SELECT *
  FROM (SELECT ROWNUM RN, A.*
        FROM (SELECT * FROM BOOK ORDER BY BRDATE DESC) A)
  WHERE RN BETWEEN 7 AND 12; -- DAO에 들어갈 QUERY
-- 3. 등록된 책 갯수
SELECT COUNT(*) CNT FROM BOOK;
-- 4. 책상세보기(BID로 DTO가져오기)
SELECT * FROM BOOK WHERE BID=1;


-- FILEBOARDDAO QUERY
--1. 글목록 (STARTROW ~ ENDROW까지 FILEBOARD 리스트)
SELECT * FROM FILEBOARD;
SELECT * FROM FILEBOARD ORDER BY FGROUP;
SELECT * FROM (SELECT ROWNUM RN, F.* FROM (SELECT * FROM FILEBOARD ORDER BY FGROUP DESC, FSTEP) F, CUSTOMER C WHERE F.CID=C.CID) 
WHERE RN BETWEEN 2 AND 4;
SELECT * FROM CUSTOMER, FILEBOARD WHERE CUSTOMER.CID=FILEBOARD.CID ORDER BY FGROUP DESC, FSTEP;

SELECT * FROM (SELECT ROWNUM RN, A.* FROM 
(SELECT C.*, F.* FROM CUSTOMER C, FILEBOARD F WHERE C.CID=F.CID ORDER BY F.FGROUP DESC, F.FSTEP) A);
SELECT C.*, F.* FROM CUSTOMER C, FILEBOARD F WHERE C.CID=F.CID;
-- 2. 전체글갯수
SELECT COUNT(*) CNT FROM FILEBOARD;
-- 3. 원글쓰기 (cid, 글제목, 본문, 첨부파일, 비밀번호, ip (fgroup은 글번호, step과 findent는 0)
INSERT INTO FILEBOARD (FID,CID,FTITLE,FCONTENT,FILENAME,FPW,FGROUP,FSTEP,FINDENT,FIP,FRDATE)
VALUES (FILEBOARD_SEQ.NEXTVAL, 'aaa1','요것이자바다','요것이자바다의설명','113.jpg','111',FILEBOARD_SEQ.CURRVAL,0,0,'127.0.0.1',SYSDATE);
INSERT INTO FILEBOARD (FID,CID,FTITLE,FCONTENT,FILENAME,FPW,FGROUP,FSTEP,FINDENT,FIP,FRDATE)
VALUES (FILEBOARD_SEQ.NEXTVAL, 'aaa1','RE:그것이알고싶다','그것이알고싶다의설명','113.jpg','111',8,1,1,'127.0.0.1',SYSDATE);
-- 4. fid로 조회수 1 올리기
UPDATE FILEBOARD SET FHIT= FHIT +1 WHERE FID = 8;
--5. fid로 dto 가져오기
SELECT * FROM FILEBOARD WHERE FID = '8';
select * from fileboard;
SELECT * FROM CUSTOMER;
-- 6. 글수정: (글제목, 본문, 첨부파일, 비밀번호, ip수정)
UPDATE FILEBOARD 
SET FTITLE= '그것이알고싶다', FCONTENT='그것이알고싶다의상세내용', FILENAME='333.JPG', FPW='111', FIP='127.0.0.1' WHERE FID='8' AND CID = 'bbb2';

-- 7. 글삭제 (fid, fpw 두 가지를 받아 일치하면 invalidate)
DELETE FROM FILEBOARD WHERE FID = '11' AND FPW = '22';
-- 8. 원글 이외의 답변글 step,indent조정작업
UPDATE FILEBOARD
SET FSTEP= FSTEP +1 WHERE FIP=8 AND FINDENT>0;
-- 9. 답변글쓰기
INSERT INTO FILEBOARD (FID,CID,FTITLE,FCONTENT,FILENAME,FPW,FGROUP,FSTEP,FINDENT,FIP,FRDATE)
VALUES (FILEBOARD_SEQ.NEXTVAL, 'aaa1','요것이자바다','요것이자바다의설명','113.jpg','111',FILEBOARD_SEQ.CURRVAL,0,0,'127.0.0.1',SYSDATE);
select * from book;
select * from customer;
select * from fileboard;
SELECT C.*, F.* FROM CUSTOMER C, FILEBOARD F WHERE C.CID=F.CID AND F.FID='8';
SELECT * FROM FILEBOARD;
UPDATE FILEBOARD SET FTITLE = '그것이알고싶네', FCONTENT = '진짜궁금하네',
FILENAME = '4444.JPG', FPW = '222' WHERE FID='82';
commit;
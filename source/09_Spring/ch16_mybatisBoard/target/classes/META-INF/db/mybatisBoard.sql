-- 1. table 및 sequence 제거
DROP TABLE MVC_BOARD;
DROP TABLE MVC_BOARD_SEQ;
-- 2. table 및 sequence 생성
    CREATE TABLE MVC_BOARD (
    BID NUMBER(6) PRIMARY KEY,
    BNAME VARCHAR2(50) NOT NULL,
    BTITLE VARCHAR2(100) NOT NULL,
    BCONTENT VARCHAR2(1000),
    BDATE DATE NOT NULL,
    BHIT NUMBER(6) NOT NULL,
    BGROUP NUMBER(6) NOT NULL,
    BSTEP NUMBER(3) NOT NULL,
    BINDENT NUMBER(30) NOT NULL,
    BIP VARCHAR2(20) NOT NULL
    );
    SELECT * FROM MEMBER;
    CREATE SEQUENCE MVC_BOARD_SEQ START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;
    SELECT * FROM MVC_BOARD;
    
    
-- 3. 더미데이터 입력 (3개이상 - 원글2개 답변글1개)
    INSERT INTO MVC_BOARD (BID, BNAME, BTITLE, BCONTENT, BDATE, BHIT, BGROUP, BSTEP, BINDENT, BIP)
    VALUES (MVC_BOARD_SEQ.NEXTVAL, '김길동', '안녕하세요', '드디어 주말이 다가왔네요..^^', SYSDATE, 0, MVC_BOARD_SEQ.CURRVAL, 0, 0, '123.120.43.1');
    
    INSERT INTO MVC_BOARD (BID, BNAME, BTITLE, BCONTENT, BDATE, BHIT, BGROUP, BSTEP, BINDENT, BIP)
    VALUES (MVC_BOARD_SEQ.NEXTVAL, 'ㄹㅇ', 'ㄹㅇ인가미케스', 'ㄹㅇ', SYSDATE, 0, MVC_BOARD_SEQ.CURRVAL, 0, 0, '3.3.43.1');
    
    INSERT INTO MVC_BOARD (BID, BNAME, BTITLE, BCONTENT, BDATE, BHIT, BGROUP, BSTEP, BINDENT, BIP)
    VALUES (MVC_BOARD_SEQ.NEXTVAL, 'ㅍㅎㅎ', '푸하하', 'ㅍㅎㄹㅇㄴㅁㅇㄴㄻ', SYSDATE, 0, 3, 1, 1, '3.3.43.1');
    
    SELECT * FROM MVC_BOARD;


-- 4. Board.xml에 들어갈 쿼리

-- 1) 글목록 (startRow, endRow 페이징) - boardList
        SELECT ROWNUM RN, A.* FROM (SELECT * FROM MVC_BOARD ORDER BY BGROUP DESC, BSTEP) A;
        SELECT * FROM (SELECT ROWNUM RN, A.* FROM (SELECT * FROM MVC_BOARD ORDER BY BGROUP DESC, BSTEP) A) WHERE RN BETWEEN 1 AND 5;
        
-- 2) 글갯수 - getBoardTotCnt
        SELECT COUNT(*) CNT FROM MVC_BOARD;
        
        
-- 3) 원글쓰기 (사용자로부터 입력받은 bname, btitle, bcontent, bip, bgroup = 글번호, bstep / bindent =0 - boardWrite
    INSERT INTO MVC_BOARD (BID, BNAME, BTITLE, BCONTENT, BDATE, BHIT, BGROUP, BSTEP, BINDENT, BIP)
    VALUES (MVC_BOARD_SEQ.NEXTVAL, '흥헹', 'ㅋㅋ', '푸하하', SYSDATE, 0, MVC_BOARD_SEQ.CURRVAL, 0, 0, '1.1.1.1');    
    
-- 4) bid로 조회수 1 올리기 - boardHitUp
    UPDATE MVC_BOARD SET BHIT = BHIT+1 WHERE BID = 5;
    
-- 5) bid로 dto 가져오기 - getBoardDto
    SELECT * FROM MVC_BOARD WHERE BID = 5;
        
-- 6) 글수정 (특정 bid를 가져와 bname, btitle, bcontent, bip 수정) - boardModify
    UPDATE MVC_BOARD SET BNAME = '진짜뉴비', BTITLE = '제발답변좀', BCONTENT = '님들아', BIP = '39.7.1.35' WHERE BID = 5;    
    
-- 7) 글삭제 (특정 bid 삭제) - boardDelete
    DELETE FROM MVC_BOARD WHERE BID = 6;    
        
--8) 답변글 저장 전단계 (엑셀 a단계) --> bstep bindent +1 > where bstep 0 - boardPreReplyStep
    UPDATE MVC_BOARD SET BSTEP = BSTEP +1, BINDENT= BINDENT +1 WHERE BGROUP = 3 AND BSTEP >0;


--9) 답변글저장 - boardReply
    INSERT INTO MVC_BOARD (BID, BNAME, BTITLE, BCONTENT, BDATE, BHIT, BGROUP, BSTEP, BINDENT, BIP)
    VALUES (MVC_BOARD_SEQ.NEXTVAL, 'ㅎㅇ','나에답변', 'ㄹㅇ', SYSDATE, 0, 3, 1, 1, '3.35.25.120');
COMMIT;
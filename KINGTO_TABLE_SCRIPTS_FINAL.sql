-----------------------------------
-------- 회원가입 테이블 생성 ---------
-----------------------------------

-- 01-1
-- LOCAL 테이블 생성
CREATE TABLE LOCAL (
    LOCAL_CODE NUMBER(3) CONSTRAINT LOCAL_CODE_PK PRIMARY KEY,
    LOCAL_NAME VARCHAR2(25) CONSTRAINT LOCAL_NAME_NN NOT NULL,
    LOCAL_NAME_ENG VARCHAR2(20) CONSTRAINT LOCAL_NAME_ENG_NN NOT NULL
);

-- 01-2
-- LOCAL 테이블 코멘트 입력
COMMENT ON COLUMN LOCAL.LOCAL_CODE IS '지역코드';
COMMENT ON COLUMN LOCAL.LOCAL_NAME IS '지역명';
COMMENT ON COLUMN LOCAL.LOCAL_NAME_ENG IS '지역명(영문)';


-- 02-1
-- NATIONALITY 테이블 생성
CREATE TABLE NATIONALITY (
    NAT_CODE NUMBER(3) CONSTRAINT NAT_CODE_PK PRIMARY KEY,
    NAT_NAME VARCHAR2(20) CONSTRAINT NAT_NAME_NN NOT NULL,
    NAT_NAME_ENG VARCHAR2(20) CONSTRAINT NAT_NAME_ENG_NN NOT NULL
);

-- 02-2
-- NATIONALITY 테이블 코멘트 입력
COMMENT ON COLUMN NATIONALITY.NAT_CODE IS '국가코드';
COMMENT ON COLUMN NATIONALITY.NAT_NAME IS '국가명';
COMMENT ON COLUMN NATIONALITY.NAT_NAME_ENG IS '국가명(영문)';


-- 03-1
-- LANGUAGE 테이블 생성
CREATE TABLE LANGUAGE (
    LANG_CODE NUMBER(20) CONSTRAINT LANG_CODE_PK PRIMARY KEY,
    LANG_NAME VARCHAR2(25) CONSTRAINT LANG_NAME_NN NOT NULL,
    LANG_NAME_ENG VARCHAR2(20) CONSTRAINT LANG_NAME_ENG_NN NOT NULL
);

-- 03-2
-- LANGUAGE 테이블 코멘트 입력
COMMENT ON COLUMN LANGUAGE.LANG_CODE IS '언어코드';
COMMENT ON COLUMN LANGUAGE.LANG_NAME IS '언어명';
COMMENT ON COLUMN LANGUAGE.LANG_NAME_ENG IS '언어명(영문)';

-- 04-1 
-- MEMBER 테이블 생성
CREATE TABLE MEMBER (
    MEMBER_NO NUMBER CONSTRAINT MEM_MEMBER_NO_PK PRIMARY KEY,
    MEMBER_STATUS VARCHAR2(1) DEFAULT 'Y' CONSTRAINT MEM_MEMBER_STATUS CHECK(MEMBER_STATUS IN('Y', 'N')),
    MEMBER_ROLE VARCHAR2(20) CONSTRAINT MEM_MEMBER_ROLE_NN NOT NULL,
    INTEREST VARCHAR2(500) CONSTRAINT MEM_MEMBER_INTEREST_NN NOT NULL,
    NAT_CODE NUMBER CONSTRAINT MEM_NAT_CODE_NN NOT NULL,
    LC_ONE NUMBER CONSTRAINT MEM_LC_ONE_NN NOT NULL,
    LC_ONE_LV NUMBER CONSTRAINT MEM_LC_ONE_LV_NN NOT NULL,
    LOCAL_CODE NUMBER CONSTRAINT MEM_LOCAL_CODE_NN NOT NULL,

    ID VARCHAR2(20) CONSTRAINT MEM_ID_NN_NOT NULL,
    PWD VARCHAR2(100) CONSTRAINT MEM_PWD_NN NOT NULL,
    EMAIL VARCHAR2(20) CONSTRAINT MEM_EMAIL_NN NOT NULL,
    NICKNAME VARCHAR2(50) CONSTRAINT MEM_NICKNAME_NN NOT NULL,
    LC_TWO NUMBER,
    LC_TWO_LV NUMBER,
    LC_THR NUMBER,
    LC_THR_LV NUMBER,

    ENROLL_DATE DATE DEFAULT SYSDATE,
    MODIFY_DATE DATE DEFAULT SYSDATE,
    ORIGINAL_FILENAME VARCHAR2(200), 


    CONSTRAINT MEMBER_ID_UQ UNIQUE(ID),
    CONSTRAINT MEMBER_NICKNAME_UQ UNIQUE(NICKNAME),

    CONSTRAINT MEM_NAT_CODE_FK FOREIGN KEY(NAT_CODE) REFERENCES NATIONALITY(NAT_CODE),
    CONSTRAINT MEM_LC_ONE_FK FOREIGN KEY(LC_ONE) REFERENCES LANGUAGE(LANG_CODE),
    CONSTRAINT MEM_LOCAL_CODE_FK FOREIGN KEY(LOCAL_CODE) REFERENCES LOCAL(LOCAL_CODE)
);

-- ▼ 중오님 REPORT 테이블이랑 연결할거 
-- ALTER TABLE MEMBER ADD CONSTRAINT MEM_MEMBER_ROLE_FK FOREIGN KEY(MEMBER_ROLE) REFERENCES REPORT(MEMBER_ROLE);

-- 04-2
-- MEMBER 테이블 코멘트 입력
COMMENT ON COLUMN MEMBER.MEMBER_NO IS '회원분류값';
COMMENT ON COLUMN MEMBER.MEMBER_STATUS IS '회원상태값';
COMMENT ON COLUMN MEMBER.MEMBER_ROLE IS '회원타입(관리자/내국인/외국인)';
COMMENT ON COLUMN MEMBER.NAT_CODE IS '국가코드(국적) ';
COMMENT ON COLUMN MEMBER.LC_ONE IS '언어코드1(모국어)';
COMMENT ON COLUMN MEMBER.LC_ONE_LV IS '언어코드1수준';
COMMENT ON COLUMN MEMBER.LOCAL_CODE IS '지역코드(지역)';
COMMENT ON COLUMN MEMBER.INTEREST IS '관심사';
COMMENT ON COLUMN MEMBER.ID IS '아이디';
COMMENT ON COLUMN MEMBER.PWD IS '비밀번호';
COMMENT ON COLUMN MEMBER.EMAIL IS '이메일';
COMMENT ON COLUMN MEMBER.NICKNAME IS '닉네임';
COMMENT ON COLUMN MEMBER.LC_TWO IS '언어코드2';
COMMENT ON COLUMN MEMBER.LC_TWO_LV IS '언어코드2수준';
COMMENT ON COLUMN MEMBER.LC_THR IS '언어코드3';
COMMENT ON COLUMN MEMBER.LC_THR_LV IS '언어코드3수준';
COMMENT ON COLUMN MEMBER.ORIGINAL_FILENAME IS '프로필사진';
COMMENT ON COLUMN MEMBER.ENROLL_DATE IS '가입일';
COMMENT ON COLUMN MEMBER.MODIFY_DATE IS '수정일';

COMMIT;

-----------------------------------
------------ 데이터 추가 ------------
-----------------------------------
-- 01
-- LOCAL 테이블 데이터 추가
INSERT INTO LOCAL VALUES (1, '서울특별시', 'Seoul');
INSERT INTO LOCAL VALUES (2, '인천광역시', 'Incheon');
INSERT INTO LOCAL VALUES (3, '세종특별자치시', 'Sejong');
INSERT INTO LOCAL VALUES (4, '대전광역시', 'Daejeon');
INSERT INTO LOCAL VALUES (5, '대구광역시', 'Daegu');
INSERT INTO LOCAL VALUES (6, '광주광역시', 'Gwangju');
INSERT INTO LOCAL VALUES (7, '울산광역시', 'Ulsan');
INSERT INTO LOCAL VALUES (8, '부산광역시', 'Busan');
INSERT INTO LOCAL VALUES (9, '경기도', 'Gyeonggi-do');
INSERT INTO LOCAL VALUES (10, '강원도', 'Gangwon-do');
INSERT INTO LOCAL VALUES (11, '충청남도', 'Chungcheongnam-do');
INSERT INTO LOCAL VALUES (12, '충청북도', 'Chungcheongbuk-do');
INSERT INTO LOCAL VALUES (13, '전라남도', 'Jeollanam-do');
INSERT INTO LOCAL VALUES (14, '전라북도', 'Jeollabuk-do');
INSERT INTO LOCAL VALUES (15, '경상남도', 'Gyeongsangnam-do');
INSERT INTO LOCAL VALUES (16, '경상북도', 'Gyeongsangbuk-do');
INSERT INTO LOCAL VALUES (17, '제주도', 'Jeju');
INSERT INTO LOCAL VALUES (18, '기타(국외)', 'etc(Other country)');

COMMIT; 



-- 02
-- NATIONALITY 테이블 데이터 추가 
INSERT INTO NATIONALITY VALUES (1, '대한민국', 'South Korea');
INSERT INTO NATIONALITY VALUES (2, '미국 ', 'USA');
INSERT INTO NATIONALITY VALUES (3, '일본', 'Japan');
INSERT INTO NATIONALITY VALUES (4, '중국', 'China');
INSERT INTO NATIONALITY VALUES (5, '홍콩', 'Hongkong');
INSERT INTO NATIONALITY VALUES (6, '베트남', 'Vietnam');
INSERT INTO NATIONALITY VALUES (7, '인도', 'India');
INSERT INTO NATIONALITY VALUES (8, '러시아', 'Russia');
INSERT INTO NATIONALITY VALUES (9, '터키', 'Turkey');
INSERT INTO NATIONALITY VALUES (10, '캐나다', 'Canada');
INSERT INTO NATIONALITY VALUES (11, '독일', 'Germany');
INSERT INTO NATIONALITY VALUES (12, '영국', 'England');
INSERT INTO NATIONALITY VALUES (13, '프랑스', 'France');
INSERT INTO NATIONALITY VALUES (14, '이탈리아', 'Italy');
INSERT INTO NATIONALITY VALUES (15, '스페인', 'Spain');

COMMIT;

-- 03
-- LANGUAGE 테이블 데이터 추가 
-- ▷ JSON 으로 구현 예정
INSERT INTO LANGUAGE VALUES (1, '한국어', 'Korean');
INSERT INTO LANGUAGE VALUES (2, '영어', 'English');
INSERT INTO LANGUAGE VALUES (3, '일본어', 'Japanese');
INSERT INTO LANGUAGE VALUES (4, '중국어', 'Chinese');
INSERT INTO LANGUAGE VALUES (5, '홍콩어', 'Cantonese');
INSERT INTO LANGUAGE VALUES (6, '베트남어', 'Vietnamese');
INSERT INTO LANGUAGE VALUES (7, '힌디어', 'Hindi');
INSERT INTO LANGUAGE VALUES (8, '러시아어', 'Russian');
INSERT INTO LANGUAGE VALUES (9, '터키어', 'Turkish');
INSERT INTO LANGUAGE VALUES (10, '독일어', 'German');
INSERT INTO LANGUAGE VALUES (11, '프랑스어', 'French');
INSERT INTO LANGUAGE VALUES (12, '이탈리아어', 'Italian');
INSERT INTO LANGUAGE VALUES (13, '스페인어', 'Spanish');

COMMIT;


-----------------------------------
------- MEMBER_NO 시퀀스 생성 -------
-----------------------------------
CREATE SEQUENCE SEQ_UNO;

COMMIT;

-----------------------------------
------- 탈퇴용 시퀀스 생성 -------
-----------------------------------
CREATE SEQUENCE SEQ_DELETE;

COMMIT;

-----------------------------------
------------ 관리자 추가  -----------
-----------------------------------
-- * 아이디 : admin, 비밀번호 : 0000
INSERT INTO MEMBER (
    MEMBER_NO, MEMBER_STATUS, MEMBER_ROLE,
    NAT_CODE, LC_ONE, LC_ONE_LV, LOCAL_CODE,INTEREST,
    ID, PWD, EMAIL, NICKNAME,
    LC_TWO, LC_TWO_LV, LC_THR, LC_THR_LV,
    ORIGINAL_FILENAME, ENROLL_DATE, MODIFY_DATE
) VALUES(
    SEQ_UNO.NEXTVAL, 'Y', '관리자',
    1, 1, 1, 1, '미식',
    'admin', 'mvFbM25qlhmShTffMLLmojdlafz51+dz7M7eZWBlKaA=', 'middle5@kh.com', '총괄관리자',
    2, 3, 4, 5,
    DEFAULT, DEFAULT, DEFAULT  
);
    
COMMIT;

-----------------------------------
---------- 회원관련 쿼리문  ----------
-----------------------------------

-- ▼ 테스트용 더미 데이터 - 내국인
-- * 아이디 : test1, 비밀번호 : 0000
INSERT INTO MEMBER (
    MEMBER_NO, MEMBER_STATUS, MEMBER_ROLE,
    NAT_CODE, LC_ONE, LC_ONE_LV, LOCAL_CODE, INTEREST,
    ID, PWD, EMAIL, NICKNAME,
    LC_TWO, LC_TWO_LV, LC_THR, LC_THR_LV,
    ORIGINAL_FILENAME, ENROLL_DATE, MODIFY_DATE
) VALUES(
    SEQ_UNO.NEXTVAL, 'Y', '내국인',
    1, 1, 1, 1, '게임',
    'test1', 'mvFbM25qlhmShTffMLLmojdlafz51+dz7M7eZWBlKaA=', 'test1@kh.com','테스트용닉네임',
    5, 4, 3, 2,
    DEFAULT, DEFAULT, DEFAULT  
);

-- ▼ 테스트용 더미 데이터 - 외국인
-- * 아이디 : test2, 비밀번호 : 0000
INSERT INTO MEMBER (
    MEMBER_NO, MEMBER_STATUS, MEMBER_ROLE,
    NAT_CODE, LC_ONE, LC_ONE_LV, LOCAL_CODE, INTEREST,
    ID, PWD, EMAIL, NICKNAME,
    LC_TWO, LC_TWO_LV, LC_THR, LC_THR_LV,
    ORIGINAL_FILENAME, ENROLL_DATE, MODIFY_DATE
) VALUES(
    SEQ_UNO.NEXTVAL, 'Y', '외국인',
    1, 1, 1, 1, '게임',
    'test2', 'mvFbM25qlhmShTffMLLmojdlafz51+dz7M7eZWBlKaA=', 'test2@kh.com','테스트용닉네임2',
    5, 4, 3, 2,
    DEFAULT, DEFAULT, DEFAULT  
);

-- 01
-- 회원 ID 조회
-- SELECT * FROM MEMBER WHERE ID=? AND MEMBER_STATUS='Y' ;


-- 02 
-- 회원 NICKNAME 조회
-- SELECT * FROM MEMBER WHERE NICKNAME=? AND MEMBER_STATUS='Y' ;


-- 03
-- 회원 가입
-- INSERT INTO MEMBER VALUES(SEQ_UNO.NEXTVAL, DEFAULT, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, DEFAULT, DEFAULT, ?);


-- 04 
-- 회원 정보 수정
-- UPDATE MEMBER SET LC_ONE=?, LC_ONE_LV=?, LOCAL_CODE=?, INT_CODE=?, EMAIL=?, NICKNAME=?, LC_TWO=?, LC_TWO_LV=?, LC_THR=?, LC_THR_LV=?,PROFILE_IMG=? WHERE MEMBER_NO=?;


-- 05 
-- 비밀번호 변경
-- UPDATE MEMBER SET PWD=? WHERE MEMBER_NO=?;


-- 06
-- 회원 탈퇴
-- UPDATE MEMBER SET MEMBER_STATUS=?,NICKNAME=SEQ_DELETE.NEXTVAL,ID=SEQ_DELETE.NEXTVAL WHERE MEMBER_NO=?;



-- SEMI 계정 생성
-- CREATE USER SEMI IDENTIFIED BY SEMI;
-- GRANT RESOURCE, CONNECT TO SEMI;


------------------------------------------------------------------
--------------------------공지사항 테이블----------------------------
------------------------------------------------------------------
CREATE TABLE NOTICE (
    NOTICE_NO NUMBER,
    WRITER_NO NUMBER, 
	TITLE VARCHAR2(50), 
	CONTENT VARCHAR2(2000), 
	READCOUNT NUMBER DEFAULT 0, 
    STATUS VARCHAR2(1) DEFAULT 'Y' CHECK (STATUS IN('Y', 'N')),
    CREATE_DATE DATE DEFAULT SYSDATE, 
    MODIFY_DATE DATE DEFAULT SYSDATE,
    CONSTRAINT PK_NOTICE_NO PRIMARY KEY(NOTICE_NO),
    CONSTRAINT FK_NOTICE_WRITER FOREIGN KEY(WRITER_NO) REFERENCES MEMBER(MEMBER_NO) ON DELETE SET NULL
);

COMMENT ON COLUMN NOTICE.NOTICE_NO IS '게시글번호';
COMMENT ON COLUMN NOTICE.WRITER_NO IS '게시글작성자번호';
COMMENT ON COLUMN NOTICE.TITLE IS '게시글제목';
COMMENT ON COLUMN NOTICE.CONTENT IS '게시글내용';
COMMENT ON COLUMN NOTICE.READCOUNT IS '조회수';
COMMENT ON COLUMN NOTICE.STATUS IS '상태값(Y/N)';
COMMENT ON COLUMN NOTICE.CREATE_DATE IS '게시글올린날짜';
COMMENT ON COLUMN NOTICE.MODIFY_DATE IS '게시글수정날짜';

CREATE SEQUENCE SEQ_NOTICE_NO;

INSERT INTO NOTICE VALUES(SEQ_NOTICE_NO.NEXTVAL, 1, '게시글 1',  '이 게시글은 영국에서 시작해서...', DEFAULT, 'Y', SYSDATE, SYSDATE);

COMMIT;

BEGIN
    FOR N IN 1..52
    LOOP
        INSERT INTO NOTICE VALUES(SEQ_NOTICE_NO.NEXTVAL, 1, '게시글 ' || SEQ_NOTICE_NO.CURRVAL , '이 게시글은 영국에서 시작해서..' ||  SEQ_NOTICE_NO.CURRVAL, DEFAULT, 'Y', SYSDATE, SYSDATE);
    END LOOP;
    
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN ROLLBACK;
END;
/








------------------------------------------------
--------------- LIKE 테이블 미구현 ---------------
------------------------------------------------

CREATE TABLE LIKE (                                                           -- LIKE 명으로 테이블 생성
    NO NUMBER,                                                                -- 컬럼명 NO , 데이터 타입 NUMBER / 좋아요번호
    FEED_NO NUMBER,                                                         -- 컬럼명 FEED_NO , 데이터 타입 NUMBER / 피드번호
    LIKE_MEMBER NUMBER,                                                    -- 컬럼명 LIKE_MEMBER , 데이터 타입 NUMBER / 좋아요를 누른 회원
    STATUS VARCHAR2(1) DEFAULT 'Y' CHECK (STATUS IN('Y', 'N')),   -- 컬럼명 STATUS , 데이터 타입 VARCHAR2(1) , 기본값 'Y', CHECK 제약 조건 STATUS 속성에 'Y', 'N'만 가능 / 상태값(Y/N)
    CONSTRAINT PK_LIKE_NO PRIMARY KEY(NO),                        -- 제약 조건명 PK_LIKE_NO , 기본키 설정 컬럼 NO
    CONSTRAINT FK_LIKE_FEED FOREIGN KEY(FEED_NO) REFERENCES FEED(NO) ON DELETE SET NULL,
                                                                                     -- 제약 조건명 FK_LIKE_FEED, 외래키 설정 컬럼 FEED_NO, 부모 테이블및 컬럼 MEMBER(MEMBER_NO),  ON DELETE SET NULL추가
    CONSTRAINT FK_LIKE_MEMBER FOREIGN KEY(LIKE_MEMBER) REFERENCES MEMBER(MEMBER_NO) ON DELETE SET NULL
                                                                                     -- 제약 조건명 FK_LIKE_MEMBER, 외래키 설정 컬럼 LIKE_MEMBER, 부모 테이블및 컬럼 MEMBER(MEMBER_NO),  ON DELETE SET NULL추가
);

-- ON DELETE SET NULL : 옵션이 없을 경우는 에러가 발생하고 옵션이 SET NULL 로 정의되면 하위테이블의 reference값이  NULL 값으로 변경되면서 참조무결성을 유지

COMMENT ON COLUMN NO IS '좋아요 번호';
COMMENT ON COLUMN FEED_NO IS '피드번호';
COMMENT ON COLUMN LIKE_MEMBER IS '회원번호';
COMMENT ON COLUMN STATUS IS '상태값(Y/N)';



-- 좋아요 갯수
-- SELECT COUNT(*) FROM LIKE WHERE FEED_NO=? AND STATUS='Y'
------------------------------------------------------------
-- SELECT COUNT(*) 
-- FROM LIKE 
-- WHERE FEED_NO=(피드번호) AND STATUS='Y'
------------------------------------------------------------


-- 좋아요 조회
-- SELECT FEED_NO, LIKE_MEMBER FROM FEED WHERE FEED_NO=? AND LIKE_MEMBER=? AND STATUS=?
------------------------------------------------------------
-- SELECT NO, FEED_NO, LIKE_MEMBER, STATUS
-- FROM LIKE 
-- WHERE FEED_NO=(피드번호) AND LIKE_MEMBER=(회원번호) AND STATUS=(상태)
------------------------------------------------------------


-- 좋아요 작성
-- INSERT INTO LIKE VALUES(SEQ_BOARD_NO.NEXTVAL,?,?,?)
------------------------------------------------------------
-- INSERT INTO LIKE 
-- VALUES(번호, (피드번호), (회원번호), (상태))
------------------------------------------------------------


-- 좋아요 수정
-- UPDATE LIKE STATUS=? WHERE NO=?
------------------------------------------------------------
-- UPDATE LIKE SET 
-- STATUS=(상태)
-- WHERE NO=(피드번호)
------------------------------------------------------------






-------------------------------------주의사항------------------------------------------
----------------------------------------------------------------------------------------
--FEED테이블은 MEMBER테이블를 외래키를 사용하고 있습니다.
--MEMBER 테이블들이 먼저 생성되어있는지 확인 후 복사 후 붙여넣어주세요
----복붙 여기 까지부분가지 복사후 사용 하시면 됩니다.--------
----------------------------------------------------------------------------------------


------------------------------------------------
--------------- FEED 테이블 ---------------
------------------------------------------------

CREATE TABLE FEED (                                                           -- FEED명으로 테이블 생성
    NO NUMBER,                                                                 -- 컬럼명 NO , 데이터 타입 NUMBER / 피드번호
    WRITER_NO NUMBER,                                                      -- 컬럼명 WRITER_NO , 데이터 타입 NUMBER / 피드작성자번호
    CONTENT VARCHAR2(600),                                               -- 컬럼명 CONTENT , 데이터 타입 VARCHAR2(600) / 피드내용
    INTEREST VARCHAR2(500),                                                   -- 컬럼명 INTEREST, 데이터 타입 VARCHAR2(500) / 관심사
    ORIGINAL_FILENAME VARCHAR2(100),                                  -- 컬럼명 ORIGINAL_FILENAME , 데이터 타입 VARCHAR2(100) / 첨부파일원래이름
    RENAMED_FILENAME VARCHAR2(100),                                 -- 컬럼명 RENAMED_FILENAME , 데이터 타입 VARCHAR2(100) / 첨부파일변경이름
    STATUS VARCHAR2(1) DEFAULT 'Y' CHECK (STATUS IN('Y', 'N')),   -- 컬럼명 STATUS , 데이터 타입 VARCHAR2(1) , 기본값 'Y', CHECK 제약 조건 STATUS 속성에 'Y', 'N'만 가능 / 상태값(Y/N)
    CREATE_DATE DATE DEFAULT SYSDATE,                                -- 컬럼명 CREATE_DATE , 데이터 타입 DATE , 기본값 SYSDATE / 피드올린날짜
    MODIFY_DATE DATE DEFAULT SYSDATE,                                -- 컬럼명 MODIFY_DATE , 데이터 타입 DATE , 기본값  SYSDATE / 피드수정날짜
    CONSTRAINT PK_FEED_NO PRIMARY KEY(NO),                        -- 제약 조건명 PK_FEED_NO , 기본키 설정 컬럼 NO
    CONSTRAINT FK_FEED_MEMBER FOREIGN KEY(WRITER_NO) REFERENCES MEMBER(MEMBER_NO) ON DELETE SET NULL
                                                                                      -- 제약 조건명 FK_FEED_WRITER, 외래키 설정 컬럼 WRITER_NO, 부모 테이블및 컬럼 MEMBER(MEMBER_NO), ON DELETE SET NULL추가
--    CONSTRAINT FK_FEED_INTEREST FOREIGN KEY(INT_CODE) REFERENCES INTEREST(INT_CODE)
                                                                                      -- 제약 조건명 FK_FEED_INTEREST, 외래키 설정 컬럼 INT_CODE, 부모 테이블및 컬럼 INTEREST(INT_CODE)
);

COMMENT ON COLUMN FEED.NO IS '피드번호';
COMMENT ON COLUMN FEED.WRITER_NO IS '피드작성자';
COMMENT ON COLUMN FEED.CONTENT IS '피드내용';
COMMENT ON COLUMN FEED.INTEREST IS '관심사';
COMMENT ON COLUMN FEED.ORIGINAL_FILENAME IS '첨부파일원래이름';
COMMENT ON COLUMN FEED.RENAMED_FILENAME IS '첨부파일변경이름';
COMMENT ON COLUMN FEED.STATUS IS '상태값(Y/N)';
COMMENT ON COLUMN FEED.CREATE_DATE IS '피드올린날짜';
COMMENT ON COLUMN FEED.MODIFY_DATE IS '피드수정날짜';

COMMIT;

-- 피드 테스트용 더미 데이터 목록 만들기 어드민의 피드

CREATE SEQUENCE SEQ_FEED_NO;

BEGIN
    FOR N IN 1..20
    LOOP
        INSERT INTO FEED VALUES(SEQ_FEED_NO.NEXTVAL, 1, '이 게시글은 영국에서 시작해서..' ||  SEQ_FEED_NO.CURRVAL, '미식',null, null, 'Y', SYSDATE, SYSDATE);
    END LOOP;
    
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN ROLLBACK;
END;


-- 피드 테스트용 더미 데이터 목록 만들기 테스트1번의 피드

BEGIN
    FOR N IN 21..40
    LOOP
        INSERT INTO FEED VALUES(SEQ_FEED_NO.NEXTVAL, 2, '이 게시글은 영국에서 시작해서..' ||  SEQ_FEED_NO.CURRVAL,'게임' ,null, null, 'Y', SYSDATE, SYSDATE);
    END LOOP;
    
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN ROLLBACK;
END;





--------------------------------------------------------------------
------------------------- FEED_REPLIES 테이블 -------------------------
--------------------------------------------------------------------

CREATE TABLE FEED_REPLIES (                                                          -- FEED_REPLY 명으로 테이블 생성
  NO NUMBER,                                                                          -- 컬럼명 NO , 데이터 타입 NUMBER / 댓글번호
  FEED_NO NUMBER,                                                                   -- 컬럼명 FEED_NO , 데이터 타입 NUMBER  / 댓글이작성된게시글
  WRITER_NO NUMBER,                                                               -- 컬럼명 WRITER_NO , 데이터 타입 NUMBER / 댓글작성자
  CONTENT VARCHAR2(300),                                                         -- 컬럼명 CONTENT , 데이터 타입 VARCHAR2(300) / 댓글내용
  STATUS VARCHAR2(1) DEFAULT 'Y' CHECK (STATUS IN ('Y', 'N')),           -- 컬럼명 STATUS , 데이터 타입 VARCHAR2(1) , 기본값 'Y', CHECK 제약 조건 STATUS 속성에 'Y', 'N'만 가능 / 상태값(Y/N)
  CREATE_DATE DATE DEFAULT SYSDATE,                                         -- 컬럼명 CREATE_DATE , 데이터 타입 DATE , 기본값  SYSDATE / 댓글 올린 날짜
  MODIFY_DATE DATE DEFAULT SYSDATE,                                         -- 컬럼명 MODIFY_DATE , 데이터 타입 DATE , 기본값  SYSDATE / 댓글 수정 날짜
  CONSTRAINT PK_REPLIES_NO PRIMARY KEY(NO),                                -- 제약 조건명 PK_REPLY_NO, 기본키 설정 컬럼 NO
  CONSTRAINT FK_REPLIES_FEED FOREIGN KEY (FEED_NO) REFERENCES FEED(NO), -- 제약 조건명 FK_REPLY_FEED, 외래키 설정 컬럼 FEED_NO, 부모 테이블및 컬럼 FEED(NO)
  CONSTRAINT FK_REPLIES_MEMBER FOREIGN KEY (WRITER_NO) REFERENCES MEMBER(MEMBER_NO) -- 제약 조건명 FK_REPLY_MEMBER,  외래키 설정 컬럼 WRITER_NO, 부모 테이블및 컬럼 FEED(NO)
);

COMMIT;

COMMENT ON COLUMN FEED_REPLIES.NO IS '댓글번호';
COMMENT ON COLUMN FEED_REPLIES.FEED_NO IS '댓글이 작성된 게시글';
COMMENT ON COLUMN FEED_REPLIES.WRITER_NO IS '댓글작성자';
COMMENT ON COLUMN FEED_REPLIES.CONTENT IS '댓글내용';
COMMENT ON COLUMN FEED_REPLIES.STATUS IS '상태값(Y/N)';
COMMENT ON COLUMN FEED_REPLIES.CREATE_DATE IS '댓글올린날짜';
COMMENT ON COLUMN FEED_REPLIES.MODIFY_DATE IS '댓글수정날짜';

CREATE SEQUENCE SEQ_REPLIES_NO;

INSERT INTO FEED_REPLIES VALUES(SEQ_REPLIES_NO.NEXTVAL, 40, 2, '테스트1 안녕하세요.', DEFAULT, DEFAULT, DEFAULT);
INSERT INTO FEED_REPLIES VALUES(SEQ_REPLIES_NO.NEXTVAL, 40, 1, '어드민1 반갑습니다.', DEFAULT, DEFAULT, DEFAULT);
INSERT INTO FEED_REPLIES VALUES(SEQ_REPLIES_NO.NEXTVAL, 35, 2, '테스트1 안녕하세요.', DEFAULT, DEFAULT, DEFAULT);
INSERT INTO FEED_REPLIES VALUES(SEQ_REPLIES_NO.NEXTVAL, 35, 1, '어드민1 반갑습니다.', DEFAULT, DEFAULT, DEFAULT);

COMMIT;




------------------------------------------------
--------------- 소모임 관련 테이블 ---------------
------------------------------------------------
-- SGROUP 테이블 생성
CREATE TABLE SGROUP (
    SGROUP_NO        NUMBER,
    SGROUP_ADMIN     NUMBER, 
    SGROUP_NAME      VARCHAR2(20) NOT NULL,
    SGROUP_OPEN      VARCHAR2(1) DEFAULT 'Y' CHECK (SGROUP_OPEN IN('Y', 'N')),
    SGROUP_INTEREST  VARCHAR2(500),
    SGROUP_INTRODUCE VARCHAR2(100),
    SGROUP_IMG       VARCHAR2(100),
    CONSTRAINT PK_SGROUP_NO PRIMARY KEY(SGROUP_NO),
    CONSTRAINT FK_SGROUP_ADMIN FOREIGN KEY(SGROUP_ADMIN) REFERENCES MEMBER(MEMBER_NO)
);

-- SGROUP 테이블 코멘트 입력
COMMENT ON COLUMN SGROUP.SGROUP_NO IS '소모임 번호';
COMMENT ON COLUMN SGROUP.SGROUP_ADMIN IS '모임장';
COMMENT ON COLUMN SGROUP.SGROUP_NAME IS '모임명';
COMMENT ON COLUMN SGROUP.SGROUP_OPEN IS '모임공개여부(Y/N)';
COMMENT ON COLUMN SGROUP.SGROUP_INTEREST IS '모임관심사';
COMMENT ON COLUMN SGROUP.SGROUP_INTRODUCE IS '모임소개';
COMMENT ON COLUMN SGROUP.SGROUP_IMG IS '모임사진';
 
CREATE SEQUENCE SEQ_SGROUP_NO;

--소모임 테스트용 데이터
INSERT INTO SGROUP VALUES(SEQ_SGROUP_NO.NEXTVAL, 1, '소모임' ||  SEQ_SGROUP_NO.CURRVAL,  DEFAULT, '미식', '모임소개합니다.', DEFAULT);

BEGIN
    FOR N IN 1..52
    LOOP
        INSERT INTO SGROUP VALUES(SEQ_SGROUP_NO.NEXTVAL, 1, '소모임' ||  SEQ_SGROUP_NO.CURRVAL,  DEFAULT, '미식', '모임소개합니다.', DEFAULT);
    END LOOP;
    
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN ROLLBACK;
END;
/

--TRUNCATE TABLE SGROUP;

-- 상세 조회
/*
SELECT  S.SGROUP_NO, S.SGROUP_ADMIN, S.SGROUP_NAME, S.SGROUP_OPEN, S.SGROUP_INTRODUCE, S.SGROUP_IMG
FROM SGROUP S
JOIN MEMBER M ON(S.SGROUP_ADMIN = M.MEMBER_NO)
WHERE S.STATUS_OPEN = 'Y' AND S.NO=?
*/

--목록 조회(페이징) 쿼리 최신순
/*
SELECT RNUM, SGROUP_NO, SGROUP_NAME, ID, MEMBER_NO, SGROUP_OPEN, INTEREST, SGROUP_INTRODUCE, SGROUP_IMG
FROM (
    SELECT ROWNUM AS RNUM, SGROUP_NO, SGROUP_NAME, ID, MEMBER_NO, SGROUP_OPEN, INTEREST, SGROUP_INTRODUCE, SGROUP_IMG
    FROM (
        SELECT  S.SGROUP_NO, S.SGROUP_NAME, M.ID, M.MEMBER_NO, S.SGROUP_OPEN, M.INTEREST, S.SGROUP_INTRODUCE, S.SGROUP_IMG
        FROM SGROUP S JOIN MEMBER M ON(S.SGROUP_ADMIN = M.MEMBER_NO)
        WHERE S.SGROUP_OPEN = 'Y'  ORDER BY S.SGROUP_NO DESC
    )
)
WHERE RNUM BETWEEN 1 and 3;
*/
/*
                "SELECT RNUM, SGROUP_NO, SGROUP_NAME, ID, MEMBER_NO, SGROUP_OPEN, INTEREST, SGROUP_INTRODUCE, SGROUP_IMG "
				+ "FROM ("
				+    "SELECT ROWNUM AS RNUM, "
				+           "SGROUP_NO, "
				+ 			"SGROUP_NAME, "
                + 			"ID, "
				+ 			"MEMBER_NO, "
				+ 			"SGROUP_OPEN, "
                + 			"INTEREST, "
				+ 			"SGROUP_INTRODUCE, "
				+  			"SGROUP_IMG "
				+ 	 "FROM ("
				+ 	    "SELECT S.SGROUP_NO, "
				+ 			   "S.SGROUP_NAME, "
                + 			   "M.ID, "
				+  			   "M.MEMBER_NO, "
				+ 			   "S.SGROUP_OPEN, "
                + 			   "M.INTEREST, "
				+ 			   "S.SGROUP_INTRODUCE, "
				+ 			   "S.SGROUP_IMG "
				+ 		"FROM SGROUP S "
				+ 		"JOIN MEMBER M ON(S.SGROUP_ADMIN = M.MEMBER_NO) "
				+ 		"WHERE S.SGROUP_OPEN = 'Y' ORDER BY S.SGROUP_NO DESC"
				+ 	 ")"
				+ ") WHERE RNUM BETWEEN ? and ?";
*/

-- 
------------------------------------------------
--------------- 소모임멤버 관련 테이블 ---------------
------------------------------------------------
-- SGROUP_MEMBER 테이블 생성
CREATE TABLE SGROUP_MEMBER(
    SMEMBER_NO     NUMBER,
    SMEMBER_MEMBER NUMBER,
    CONSTRAINT FK_SMEMBER_NO FOREIGN KEY(SMEMBER_NO) REFERENCES SGROUP(SGROUP_NO),
    CONSTRAINT FK_SMEMBER_MEMBER FOREIGN KEY(SMEMBER_MEMBER) REFERENCES MEMBER(MEMBER_NO)
);

-- SGROUP_MEMBER 테이블 코멘트 입력
COMMENT ON COLUMN SGROUP_MEMBER.SMEMBER_NO IS '가입된소모임';
COMMENT ON COLUMN SGROUP_MEMBER.SMEMBER_MEMBER IS '소모임멤버';

-- 총 소모임 개수
-- SELECT COUNT(*) FROM SGROUP WHERE SGROUP_OPEN ='Y'

------------------------------------------------
--------------- 게시글 관련 테이블 ---------------
------------------------------------------------
-- POST 테이블 생성
CREATE TABLE POST(
    POST_NO        NUMBER,
    POST_SGROUP_NO NUMBER,
    POST_MEMBER    NUMBER,
    POST_TITLE     VARCHAR2(30) NOT NULL,
    POST_CONT      VARCHAR2(1000),
    POST_READCOUNT NUMBER DEFAULT 0,
    POST_STATUS    VARCHAR2(1) DEFAULT 'Y' CHECK(POST_STATUS IN('Y', 'N')),
    POST_LIKE      VARCHAR2(1) DEFAULT 'N' CHECK(POST_LIKE IN('Y', 'N')),
    POST_CREATE   DATE DEFAULT SYSDATE,
    POST_MODIFY    DATE DEFAULT SYSDATE,
    CONSTRAINT PK_POST_NO PRIMARY KEY(POST_NO),
    CONSTRAINT FK_POST_SGROUP_NO FOREIGN KEY(POST_SGROUP_NO) REFERENCES SGROUP(SGROUP_NO),
    CONSTRAINT FK_POST_MEMBER FOREIGN KEY(POST_MEMBER) REFERENCES MEMBER(MEMBER_NO)
);

-- POST 테이블 코멘트 입력
COMMENT ON COLUMN POST.POST_NO IS '게시글번호';
COMMENT ON COLUMN POST.POST_SGROUP_NO IS '게시물이작성된모임';
COMMENT ON COLUMN POST.POST_MEMBER IS '게시글작성자';
COMMENT ON COLUMN POST.POST_TITLE IS '게시글제목';
COMMENT ON COLUMN POST.POST_CONT IS '게시글내용';
COMMENT ON COLUMN POST.POST_READCOUNT IS '조회수';
COMMENT ON COLUMN POST.POST_STATUS IS '상태값(Y/N)';
COMMENT ON COLUMN POST.POST_LIKE IS '좋아요(Y/N)';
COMMENT ON COLUMN POST.POST_CREATE IS '게시글작성일';
COMMENT ON COLUMN POST.POST_MODIFY IS '게시글수정일';

CREATE SEQUENCE SEQ_POST_NO;

-- 게시글 테스트용 데이터
INSERT INTO POST VALUES(SEQ_POST_NO.NEXTVAL, 56, 1, '게시글 1',  '이 게시글은 영국에서 시작해서...', DEFAULT, 'Y', 'N', SYSDATE, SYSDATE);

COMMIT;

BEGIN
    FOR N IN 1..52
    LOOP
        INSERT INTO POST VALUES(SEQ_POST_NO.NEXTVAL, 56, 1, '게시글 ' || SEQ_POST_NO.CURRVAL , '이 게시글은 영국에서 시작해서..' ||  SEQ_POST_NO.CURRVAL, DEFAULT, 'Y', 'N', SYSDATE, SYSDATE);
    END LOOP;
    
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN ROLLBACK;
END;
/

-- 총 게시글 갯수
-- SELECT COUNT(*) FROM POST WHERE POST_STATUS='Y'

-- 조회수 증가
-- UPDATE POST SET POST_READCOUNT=? WHERE POST_NO=?

-- 게시글 작성
-- INSERT INTO POST VALUES(SEQ_POST_POST_NO.NEXTVAL,?,?,?,?,DEFAULT,DEFAULT,DEFAULT,DEFAULT)

-- 게시글 수정
-- UPDATE POST SET POST_TITLE=?,POST_CONT=?,POST_MODIFY=SYSDATE WHERE POST_NO=?

-- 게시글 삭제
-- UPDATE POST SET STATUS=? WHERE POST_NO=?

-- 상세 조회
/*
SELECT  P.POST_NO, P.POST_TITLE, P.POST_SGROUP_NO, M.ID, P.POST_READCOUNT, P.POST_CONT, P.POST_LIKE, P.POST_CREATE, P.POST_MODIFY
FROM POST P
JOIN MEMBER M ON(P.POST_MEMBER = M.MEMBER_NO)
JOIN SGROUP S ON(P.POST_SGROUP_NO = S.SGROUP_NO)
WHERE P.POST_STATUS = 'Y' AND P.POST_NO=?
*/

--목록 조회(페이징) 쿼리

SELECT RNUM, POST_NO, POST_TITLE, POST_SGROUP_NO, ID, POST_CREATE, POST_LIKE, POST_READCOUNT, POST_STATUS   
FROM (
    SELECT ROWNUM AS RNUM, POST_NO, POST_TITLE, POST_SGROUP_NO, ID, POST_CREATE, POST_LIKE, POST_READCOUNT, POST_STATUS 
    FROM (
        SELECT  P.POST_NO, P.POST_TITLE, P.POST_SGROUP_NO, M.ID, P.POST_CREATE, P.POST_LIKE, P.POST_READCOUNT, P.POST_STATUS 
        FROM POST P 
        JOIN MEMBER M ON(P.POST_MEMBER = M.MEMBER_NO) 
        JOIN SGROUP S ON(P.POST_SGROUP_NO = S.SGROUP_NO)
        WHERE P.POST_STATUS = 'Y'  ORDER BY P.POST_NO DESC
    )
)
WHERE RNUM BETWEEN 1 and 3;

/*
                "SELECT RNUM, POST_NO, POST_TITLE, POST_SGROUP_NO, ID, POST_CREATE, POST_LIKE, POST_READCOUNT, POST_STATUS "
				+ "FROM ("
				+    "SELECT ROWNUM AS RNUM, "
				+           "POST_NO, "
				+ 			"POST_TITLE, "
                + 			"POST_SGROUP_NO, "
				+ 			"ID, "
				+ 			"POST_CREATE, "
				+ 			"POST_LIKE, "
				+  			"POST_READCOUNT, "
				+     		"POST_STATUS "
				+ 	 "FROM ("
				+ 	    "SELECT P.POST_NO, "
				+ 			   "P.POST_TITLE, "
                +  			   "P.POST_SGROUP_NO, "
				+  			   "M.MEMBER_ID, "
				+ 			   "P.POST_CREATE, "
				+ 			   "P.POST_LIKE, "
				+ 			   "P.POST_READCOUNT, "
				+ 	   		   "P.POST_STATUS "
				+ 		"FROM POST P "
				+ 		"JOIN MEMBER M ON(P.POST_MEMBER = M.MEMBER_NO) "
                + 		"JOIN SGROUP S ON(P.POST_SGROUP_NO = S.SGROUP_NO) "
				+ 		"WHERE P.POST_STATUS = 'Y' ORDER BY B.NO DESC"
				+ 	 ")"
				+ ") WHERE RNUM BETWEEN ? and ?";
*/

------------------------------------------------
--------------- 게시글댓글 관련 테이블 ---------------
------------------------------------------------
-- POST_COMMENT 테이블 생성
CREATE TABLE POST_COMMENT(
    PCOM_NO     NUMBER,
    PCOM_POST   NUMBER, 
    PCOM_MEMVER NUMBER NOT NULL,
    PCOM_CONT   VARCHAR2(100) NOT NULL,
    PCOM_STATUS VARCHAR2(1) DEFAULT 'Y' CHECK(PCOM_STATUS IN('Y', 'N')),
    PCOM_DATE   DATE DEFAULT SYSDATE,
    PCOM_MODIFY DATE DEFAULT SYSDATE,
    CONSTRAINT PK_PCOM_NO PRIMARY KEY(PCOM_NO),
    CONSTRAINT FK_PCOM_MEMVER FOREIGN KEY(PCOM_MEMVER) REFERENCES MEMBER(MEMBER_NO)
);

-- POST_COMMENT 테이블 코멘트 입력
COMMENT ON COLUMN POST_COMMENT.PCOM_NO IS '댓글번호';
COMMENT ON COLUMN POST_COMMENT.PCOM_POST IS '댓글이작성된게시글';
COMMENT ON COLUMN POST_COMMENT.PCOM_MEMBER IS '댓글작성자';
COMMENT ON COLUMN POST_COMMENT.PCOM_CONT IS '댓글내용';
COMMENT ON COLUMN POST_COMMENT.PCOM_STATUS IS '댓글상태값(Y/N)';
COMMENT ON COLUMN POST_COMMENT.PCOM_DATE IS '댓글작성일';
COMMENT ON COLUMN POST_COMMENT.PCOM_MODIFY IS '댓글수정일';

CREATE SEQUENCE SEQ_PCOM_NO;

-- 댓글 테스트용 데이터
INSERT INTO POST_COMMENT VALUES(SEQ_PCOM_NO.NEXTVAL, 3, 2, '안녕하세요.', DEFAULT, DEFAULT, DEFAULT);
INSERT INTO POST_COMMENT VALUES(SEQ_PCOM_NO.NEXTVAL, 3, 2, '반갑습니다.', DEFAULT, DEFAULT, DEFAULT);

COMMIT;

--------------------------------------------------------------------
------------------------- FRIEND 테이블 -------------------------
--------------------------------------------------------------------

-- 친구 테이블
CREATE TABLE FRIEND (
    FRND_ONE NUMBER CONSTRAINT FRND_ONE_NO REFERENCES MEMBER,
    FRND_TWO NUMBER CONSTRAINT FRND_TWO_NO REFERENCES MEMBER,
    FRND_ONE_STATUS VARCHAR2(1) DEFAULT 'N' CHECK (FRND_ONE_STATUS IN('Y', 'N')),
    FRND_TWO_STATUS VARCHAR2(1) DEFAULT 'N' CHECK (FRND_TWO_STATUS IN('Y', 'N')),
    FRND_DATE DATE DEFAULT SYSDATE,
    MODIFY_DATE DATE DEFAULT SYSDATE,
    CONSTRAINT PK_FRND_NO PRIMARY KEY(FRND_ONE, FRND_TWO)   
);

COMMENT ON COLUMN FRIEND.FRND_ONE IS '신청회원번호';
COMMENT ON COLUMN FRIEND.FRND_TWO IS '수락회원번호';
COMMENT ON COLUMN FRIEND.FRND_ONE_STATUS IS '신청회원상태';
COMMENT ON COLUMN FRIEND.FRND_TWO_STATUS IS '수락회원상태';
COMMENT ON COLUMN FRIEND.FRND_DATE IS '친구맺은시각';
COMMENT ON COLUMN FRIEND.MODIFY_DATE IS '친구수정시각';

ALTER TABLE FRIEND RENAME COLUMN FRND_ADD TO FRND_ONE;
ALTER TABLE FRIEND RENAME COLUMN FRND_ADD_STATUS TO FRND_ONE_STATUS;
ALTER TABLE FRIEND RENAME COLUMN FRND_CONFIRM TO FRND_TWO;
ALTER TABLE FRIEND RENAME COLUMN FRND_CONFIRM_STATUS TO FRND_TWO_STATUS;
ALTER TABLE FRIEND RENAME CONSTRAINT FRND_ADD_NO TO FRND_ONE_NO;
ALTER TABLE FRIEND RENAME CONSTRAINT FRND_CONFIRM_NO TO FRND_TWO_NO;

-- 친구 더미데이터
INSERT INTO FRIEND VALUES (1, 2, 'Y', 'Y', DEFAULT, DEFAULT)
-- 친삭 더미데이터
INSERT INTO FRIEND VALUES (2, 1, 'N', 'N', DEFAULT, DEFAULT)

----------------------------------------------------------------------------------------
-- 친구 관련  쿼리문
-- 친구 신청
--INSERT ALL
--    INTO FRIEND VALUES (?, ?, 'Y', DEFAULT, DEFAULT, DEFAULT)
--    INTO FRIEND VALUES (?, ?, DEFAULT, 'Y', DEFAULT, DEFAULT)
--SELECT * FROM DUAL

-- 친구 신청 수락
--UPDATE FRIEND SET (FRND_ONE_STATUS, FRND_TWO_STATUS) = (
--    SELECT FRND_ONE_STATUS, FRND_TWO_STATUS
--    FROM FRIEND
--    WHERE FRND_ONE = 1 AND FRND_TWO = 2
--)
--WHERE (FRND_ONE = ? AND FRND_TWO = ?) OR (FRND_ONE = ? AND FRND_TWO = ?)

-- 친구 수 조회
--SELECT COUNT(*) 
--FROM FRIEND 
--WHERE FRND_ONE_STATUS='Y' AND FRND_TWO_STATUS='Y' AND FRND_ONE=?

-- 친구 목록 페이징
--SELECT RNUM, MEMBER_NO, MEMBER_STATUS, NAT_CODE, LC_ONE, LC_ONE_LV, LOCAL_CODE, INTEREST, NICKNAME, ORIGINAL_FILENAME, LANG_NAME, NAT_NAME
--FROM(
--    SELECT ROWNUM AS RNUM, MEMBER_NO, MEMBER_STATUS, NAT_CODE, LC_ONE, LC_ONE_LV, LOCAL_CODE, INTEREST, NICKNAME, ORIGINAL_FILENAME, LANG_NAME, NAT_NAME
--    FROM MEMBER
--    JOIN LANGUAGE ON(LC_ONE = LANG_CODE)
--    JOIN NATIONALITY USING(NAT_CODE)
--    WHERE MEMBER_NO IN (
--                        SELECT FRND_TWO
--                        FROM MEMBER 
--                        JOIN FRIEND ON(MEMBER_NO = FRND_ONE)
--                        WHERE FRND_ONE_STATUS = 'Y' AND FRND_TWO_STATUS = 'Y' AND FRND_ONE = ?
--    )
--    ORDER BY MEMBER_NO
--)
--WHERE RNUM BETWEEN ? AND ?

-- 언어 코드로 배우고 싶은 언어 이름 받아오기
--SELECT LANG_NAME
--FROM MEMBER
--JOIN LANGUAGE ON (LC_TWO = LANG_CODE)
--WHERE MEMBER_NO = ?

-- 친구 여부 확인
--SELECT COUNT(*)
--FROM FRIEND
--WHERE FRND_ONE = ? AND FRND_TWO = ? AND FRND_ONE_STATUS = 'Y' AND FRND_TWO_STATUS = 'Y'

-- 친구 삭제 
--DELETE FROM FRIEND
--WHERE (FRND_ONE = ? AND FRND_TWO = ?) OR (FRND_ONE = ? AND FRND_TWO = ?)

-- 친구 신청 갯수 조회
--SELECT COUNT(*)
--FROM FRIEND
--WHERE FRND_ONE_STATUS = 'N' AND FRND_TWO_STATUS = 'Y' AND FRND_ONE = ?

-- 친구 신청 목록 조회
--SELECT ROWNUM AS RNUM, MEMBER_NO, NICKNAME
--FROM MEMBER
--WHERE MEMBER_NO IN (
--                    SELECT FRND_TWO
--                    FROM MEMBER 
--                    JOIN FRIEND ON(MEMBER_NO = FRND_ONE)
--                    WHERE FRND_ONE_STATUS = 'N' AND FRND_TWO_STATUS = 'Y' AND FRND_ONE = ?                    
--)

-- 검색 필터 적용 회원 조회
--SELECT RNUM, MEMBER_NO, MEMBER_STATUS, NAT_CODE, LC_ONE, LC_ONE_LV, LOCAL_CODE, INTEREST, NICKNAME, ORIGINAL_FILENAME, LANG_NAME, NAT_NAME
--FROM(
--SELECT ROWNUM AS RNUM, MEMBER_NO, MEMBER_STATUS, NAT_CODE, LC_ONE, LC_ONE_LV, LOCAL_CODE, INTEREST, NICKNAME, ORIGINAL_FILENAME, LANG_NAME, NAT_NAME 
--FROM MEMBER
--JOIN LANGUAGE ON(LC_ONE = LANG_CODE)
--JOIN NATIONALITY USING(NAT_CODE)
--WHERE 
--REGEXP_LIKE(LC_ONE, ?)
--    AND REGEXP_LIKE(LOCAL_CODE, ?) 
--    AND REGEXP_LIKE(INTEREST, ?)
--    )
--WHERE RNUM BETWEEN ? AND ?

-- 검색 필터 적용 회원수 조회    
--SELECT COUNT(*) 
--FROM MEMBER
--WHERE 
--    REGEXP_LIKE(LC_ONE, ?)
--    AND REGEXP_LIKE(LOCAL_CODE, ?) 
--    AND REGEXP_LIKE(INTEREST, ?)


-- 회원 번호로 피드 조회
--SELECT *
--FROM FEED
--JOIN MEMBER ON(WRITER_NO = MEMBER_NO)
--WHERE MEMBER_NO = ?

--SELECT RNUM, NO, ID, CONTENT, RENAMED_FILENAME, CREATE_DATE, STATUS
--FROM 
--    (SELECT ROWNUM AS RNUM, NO, ID, CONTENT, RENAMED_FILENAME, CREATE_DATE, STATUS 
--     FROM (
--            SELECT F.NO, M.ID, F.CONTENT, F.RENAMED_FILENAME, F.CREATE_DATE, F.STATUS
--            FROM FEED F JOIN MEMBER M ON(F.WRITER_NO = M.MEMBER_NO)
--            WHERE F.STATUS = 'Y' AND F.WRITER_NO = ? ORDER BY F.NO DESC
--            )
--    )
--WHERE RNUM BETWEEN ? and ?
--테이블 생성
CREATE TABLE book(
    book_id NUMBER(5),
    title VARCHAR2(50),
    author VARCHAR2(10),
    pub_date DATE
);

--계정 전체 테이블 보기
SELECT * FROM tabs;

--컬럼추가
ALTER TABLE book add ( 
    pubs   VARCHAR2(50)
);

--자료형 변경
ALTER TABLE book MODIFY(
     title VARCHAR2(100)
);

--컬럼명 변경
ALTER TABLE book RENAME COLUMN title TO subject;

--컬럼삭제
ALTER TABLE book DROP (author);

--테이블명 변경
RENAME book TO article;

--테이블명 변경
DROP TABLE article;

--
--

--테이블 확인하기
SELECT * FROM author;
SELECT * 
FROM book,author
WHERE book.author_id = author.author_id;

SELECT
    *
FROM book;

--정보입력
INSERT INTO author
VALUES (seq_author_id.nextval, '김영하', '알뜰신잡' );

INSERT INTO book
VALUES (seq_book_id.nextval,'26년','재미주의','2012-02-04',5);

--시퀀스 생성
DROP SEQUENCE seq_author_id;
SELECT * FROM USER_SEQUENCES;

CREATE SEQUENCE seq_author_id
INCREMENT BY 1 
START WITH 1 ;

CREATE SEQUENCE seq_book_id
INCREMENT BY 1 
START WITH 1 ;

--정보 수정하기
UPDATE author
SET  author_desc = '서울특별시' 
WHERE author_id = 5 ;

UPDATE book
SET  author_id = 1 
WHERE book_id = 5 ;

--정보 삭제하기
DELETE FROM author
WHERE author_id = 4 ;


commit;
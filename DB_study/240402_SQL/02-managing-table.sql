-- Table 구조 확인
PRAGMA table_info('examples');

-- 1. Create a table
CREATE TABLE examples (
    ExamId INTEGER PRIMARY KEY AUTOINCREMENT,
    LastName VARCHAR(50) NOT NULL,
    FirstName VARCHAR(50) NOT NULL
);
-- VARCHAR, INTEGER : 데이터 타입
-- PRIMARY KEY, NOT NULL : 제약조건

-- 2. Modifying table fields

-- 2.1 ADD COLUMN
ALTER TABLE
    examples
ADD COLUMN
    Country VARCHAR(100) NOT NULL DEFAULT 'default value';
-- 기존 테이블에 Country 추가

-- sqlite는 단일 문을 사용하여 한번에 여러 열을 추가하는 것을 지원하지 않음
-- 따라서 두개의 필드를 추가하려면, 반복해야함.
ALTER TABLE
    examples
ADD COLUMN
    Age INTEGER NOT NULL DEFAULT 0;
ALTER TABLE
    examples
ADD COLUMN
    Adress VARCHAR(100) NOT NULL DEFAULT 'default value';

-- 2.2 RENAME COLUMN
-- 필드명 변경
ALTER TABLE examples
RENAME COLUMN Adress TO PostCode;
-- 2.3 RENAME TO
-- 테이블 이름 변경
ALTER TABLE examples
RENAME TO new_examples;

PRAGMA table_info('new_examples');
-- 3. Delete a table
DROP TABLE new_examples;

-- sqlite는 컬럼 수정 불가
-- 대신 테이블의 이름을 바꾸고, 새 테이블을 만들고 데이터를 새 테이블에 복사하는 방식을 사용

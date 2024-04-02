-- 공통, 사전준비
SELECT * FROM articles;
-- 조회
DROP TABLE articles;
PRAGMA table_info('articles');

CREATE TABLE articles (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    title VARCHAR(100) NOT NULL,
    content VARCHAR(200) NOT NULL,
    createdAt DATE NOT NULL
);
-- 1. Insert data into table
INSERT INTO articles (title,content,createdAt)
VALUES ('hello','world','2000-01-01');

INSERT INTO articles (title,content,createdAt)
VALUES
    ('title1','content1','2001-01-01'),
    ('title2','content2','2002-02-02'),
    ('title3','content3','2003-03-03');

INSERT INTO articles (title,content,createdAt)
VALUES ('mytitle','mycontent',DATE());
-- 2. Update data in table
UPDATE articles
SET title = 'update Title'
WHERE id = 1;

UPDATE articles
SET title = 'update Title', content = 'update Content'
WHERE id = 2;

-- 3. Delete data from table
DELETE FROM articles
WHERE id = 1;
-- 해당 id를 가진 것 제거

DELETE FROM articles
WHERE id IN (
    SELECT id FROM articles
    ORDER BY createdAt
    LIMIT 2
);
-- 오래된 것 두개 제거
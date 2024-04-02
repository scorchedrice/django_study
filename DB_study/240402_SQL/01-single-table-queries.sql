-- 01. Querying data
SELECT LastName FROM employees;

-- 두가지를 같이 불러오기 위함
SELECT
    LastName, FirstName
FROM
    employees;

-- *는 모든것을 택한다는 의미
SELECT
    *
FROM
    employees;

-- 불러오는 값의 field값을 바꾸기
SELECT
    FirstName
AS
    '이름'
FROM
    employees;

-- ms값을 minute 단위 값으로 출력하는 과정
SELECT
    Name,
    Milliseconds/60000 AS '재생 시간(분)'
FROM
    tracks;

-- 02. Sorting data
-- 오름차순! FROM 뒤에서 명령어 작성
SELECT
    FirstName
AS
    '이름'
FROM
    employees
ORDER BY
    FirstName;
-- 내림차순!
SELECT
    FirstName
AS
    '이름'
FROM
    employees
ORDER BY
    FirstName DESC;

-- 오름차순과 내림차순 혼합
-- 먼저 명령한 것 하고, 그 내에서 또 명령 수행
SELECT
    Country, City
FROM
    customers
ORDER BY
    Country DESC,
    City ASC;

SELECT
    Name,
    Milliseconds / 60000 AS '재생시간(분)'
FROM
    tracks
ORDER BY
    Milliseconds DESC;

-- NULL 정렬 예시
SELECT
    ReportsTo
FROM
    employees
ORDER BY
    ReportsTo;

-- 03. Filtering data
-- DISTINCT : 중복제거
SELECT DISTINCT
    Country
FROM
    customers
ORDER BY
    Country;
-- WHERE : 해당 값 가지는 데이터 필터링
SELECT
    LastName,
    FirstName,
    City
FROM
    customers
WHERE
    City = 'Prague';

SELECT
    LastName,
    FirstName,
    City
FROM
    customers
WHERE
    City != 'Prague';
-- 여러개의 조건 : 논리연산자 활용
-- NULL은 IS 사용함.
SELECT
    LastName,
    FirstName,
    Company,
    Country
FROM
    customers
WHERE
    Company IS NULL AND Country = 'USA';

SELECT
    Name, Bytes
FROM
    tracks
WHERE
    Bytes >= 100000
    AND Bytes <= 500000;
    -- Bytes BETWEEN 100000 AND 500000;
    -- between을 활용해도 동일 값

SELECT
    LastName, FirstName, Country
FROM
    customers
WHERE
    Country = 'Canada'
    OR Country = 'Germany'
    OR Country = 'France';
    -- Country IN ('Canada','Germany','France');
    -- IN을 사용해도 동일 값

-- LIKE : 끝 혹은 시작에 ~로 끝나는 것 필터링
-- % : 0개 이상의 문자열
-- _ : 단일 문자와 일치하는지
SELECT
    LastName, FirstName
FROM
    customers
WHERE
    LastName LIKE '%son';

-- 네자리면서 a로 끝나는 것들 필터링
SELECT
    LastName,FirstName
FROM
    customers
WHERE
    FirstName Like '___a';

SELECT
    TrackId, Name, Bytes
FROM
    tracks
ORDER BY
    Bytes DESC
LIMIT
    7;
-- 04. Grouping data
SELECT
    Country, COUNT(*)
FROM
    customers
GROUP BY
    Country;

SELECT
    Composer, AVG(Bytes)
FROM
    tracks
GROUP BY
    Composer
ORDER BY
    AVG(Bytes) DESC;

-- group by의 경우 where 사용 불가
-- HAVING 사용해야함
SELECT
    Composer,
    AVG(Milliseconds / 60000) AS avgOfMin
FROM
    tracks
GROUP BY
    Composer
HAVING
    avgOfMin < 10;


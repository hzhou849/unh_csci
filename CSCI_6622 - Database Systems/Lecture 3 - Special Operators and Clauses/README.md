## Lecture 3 - Special Operators and Clauses
#### 3.1
* 3.1 - IN
* 3.1.2 BETWEEN
* LIKE
* DISTINCT Clause
* ORDERY BY Clause

#### 3.2
* 3.2.1 Numeric functions (Math)
* 3.2.2 String Functions
* 3.2.3 Date time functions

#### 3.3 Aggregate Functions
* 3.3.1 Aggregate functions
* 3.3.3 GROUP BY
* 3.3.5 HAVING clause
* 3.3.8 Aggregate NULL values

#### 3.4 Join
#### 3.5 Equijoin, self-joins and cross-joins
#### 3.6 Subqueries
#### 3.7 Complex Query example


## 3.1
### 3.1 IN operator
* The IN operator is used in a WHERE clause to determine if a value matches one of several values. The SELECT statement in the figure below uses the IN operator to select only rows where the Language column has a Dutch, Kongo, or Albanian value
* Select category Language IN ('myOption', 'myOption2', ...)

```sql
-- Returns all Columns that contain Dutch, Kongo, Albanian
SELECT * 
FROM CountryLanguage 
WHERE Language IN ('Dutch', 'Kongo', 'Albanian');

-- Returns the Name field only
SELECT Name 
FROM Country 
WHERE Continent IN ('Asia', 'Europe', 'North America');
```

### 3.2 BETWEEN operator
* Works similar to \<condition1> AND \<condition2>
* Equivalent to \>= AND \<= (inclusive)
```sql
SELECT Name
FROM Employee
WHERE HireDate >= '2000-01-01' AND HireDate <= '2020-01-01';


SELECT Name
FROM Employee
WHERE HireDate BETWEEN '2000-01-01' AND '2020-01-01'
```

### LIKE
* The LIKE operator, when used in a WHERE clause, matches text against a pattern using the two wildcard characters % and _.
* % matches any number of characters. Ex: LIKE 'L%t' matches "Lt", "Lot", "Lift", and "Lol cat".
* _ matches exactly one character. Ex: LIKE 'L_t' matches "Lot" and "Lit" but not "Lt" and "Loot".
* The LIKE operator performs case-insensitive pattern matching by default or case-sensitive pattern matching if followed by the BINARY keyword. Ex: LIKE BINARY 'L%t' matches 'Left' but not 'left'.
* To search for the wildcard characters or any length % or _, a backslash (\) must precede % or _. Ex: LIKE 'a\%' matches "a%".

```sql
SELECT *
FROM <MyTable>
-- This will return rows with Column_name containing  ABW and ARW
WHERE <Column_name> LIKE 'A_W';

-- This will return any length that is A to n. ex Albanian, Algerian etc...
WHERE <Column_name> LIKE 'A%n';

-- This will return anylength and character - ex A____
-- To search for a character you must use escape char '\'
WHERE <Column_name> Like 'A%' ;
WHERE <Column_name> Like 'A\%' ;

-- Case sensitive search use BINARY
LIKE BINARY 'L%t' matches 'Left' not 'left'

```

### DISTINCT
* Use this if you don't need to return duplicate results

This will return repeated results ie. {spanish, balochi, spanish}
```sql
SELECT Language
FROM CountryLanguage
WHERE IsOfficial = 'F';
```
Using ```DISTINCT``` will only return {spanish, balochi} and not repeat duplicate results
```sql
SELECT DISTINCT Language
FROM CountryLanguage
WHERE IsOfficial = 'F';
```

## ORDER BY clause
* Since ```SELECT``` statements don't return a table in order. The ORDER BY clause orders selected rows
* Returns by default in alphabetical ASCENDING.
* Use ```DESC``` keyword to order by descending order

``` ORDER BY \<column_name> DESC, \<column_name2>```

```sql
-- Order by Language (ascending) 
SELECT * 
FROM CountryLanguage 
ORDER BY Language;
 
GAB   Fang    F   35.8
GAB   Mbete   F   13.8
FSM   Woleai  F    3.7
FSM   Yap     F    5.8

-- Order by Language (descending)
SELECT * 
FROM CountryLanguage 
ORDER BY Language DESC;
 
FSM   Yap     F    5.8
FSM   Woleai  F    3.7
GAB   Mbete   F   13.8
GAB   Fang    F   35.8

-- Order by CountryCode, then    
-- Language (ascending)
SELECT * 
FROM CountryLanguage 
ORDER BY CountryCode, Language;
 
FSM   Woleai  F    3.7
FSM   Yap     F    5.8
GAB   Fang    F    35.8
GAB   Mbete   F    13.8
```


## 3.2 

### 3.2.1  Arithmetic functions
| Function |	Description |	Example |
| -------- | ----------- | ------- |
| ABS(n)	| Returns the absolute value of n	| ```sql SELECT ABS(-5);``` <br>returns 5 |
| LOG(n) |	Returns the natural logarithm of n	| ```SELECT LOG(10);``` <br>returns 2.302585092994046 |
| POW(x, y)	| Returns x to the power of y |	```SELECT POW(2, 3); ``` <br> returns 8 |
| RAND() |	Returns a random number between 0 (inclusive) and 1 (exclusive) |	```SELECT RAND();``` <br>returns 0.11831825703225868 |
| ROUND(n, d)	| Returns n rounded to d decimal places	 | ```SELECT ROUND(16.25, 1);``` <br>returns 16.3 |
| SQRT(n) |	Returns the square root of n	| ```SELECT SQRT(25);``` <br>returns 5 |

* EXample: Compute Column X plus a random number rounded to 3 decimal places for all rows
```sql
ROUND(X + RAND(), 3)
```
* EXample: 
```sql
SELECT ABS(X) * SQRT(Y);
```
* Example2:
```sql
SELECT X + RAND();
```

### 3.2.2 String Functions
| Function |	Description |	Example |
| -------- | ----------- | ------- |
| CONCAT(s1, s2, ...)	|Returns the string that results from concatenating the string arguments	| SELECT CONCAT('Dis', 'en', 'gage'); <br> returns 'Disengage' |
|LOWER(s)	| Returns the lowercase s	| SELECT LOWER('MySQL'); <br>returns 'mysql' |
| REPLACE(s, from, to)	| Returns the string s with all occurrences of from replaced with to	| SELECT REPLACE('This and that', 'and', 'or'); <br>returns 'This or that' |
| SUBSTRING(s, pos, len)	| Returns the substring from s that starts at position pos and has length len	| SELECT SUBSTRING('Boomerang', 1, 4);<br>returns 'Boom' |
| TRIM(s)	| Returns the string s without leading and trailing spaces	| SELECT TRIM('   test   '); <br>returns 'test' |
| UPPER(s)	| Returns the uppercase s	| SELECT UPPER('mysql'); <br>returns 'MYSQL' |

### 3.2.3 Date time functions
| Function |	Description |	Example |
| -------- | ----------- | ------- |
| CURDATE() CURTIME() NOW() |	Returns the current date, time, or date and time in <br>'YYYY-MM-DD', 'HH:MM:SS', or 'YYYY-MM-DD HH:MM:SS' format | <br> SELECT CURDATE(); returns '2019-01-25' <br> SELECT CURTIME(); returns '21:05:44' <br> SELECT NOW(); returns '2019-01-25 21:05:44' |
| DATE(expr) <br> TIME(expr) |	Extracts the date or time from a date or datetime expression expr	| SELECT DATE('2013-03-25 22:11:45'); returns '2013-03-25' <br>SELECT TIME('2013-03-25 22:11:45'); returns '22:11:45' |
| DAY(d) <br> MONTH(d) <br> YEAR(d) 	Returns the day, month, or year from date d	| SELECT DAY('2016-10-25'); returns 25 <br>SELECT MONTH('2016-10-25'); returns 10 <br> SELECT YEAR('2016-10-25'); returns 2016 |
| HOUR(t) <br> MINUTE(t) <br> SECOND(t)	| Returns the hour, minute, or second from time t	| SELECT HOUR('22:11:45'); returns 22 <br> SELECT MINUTE('22:11:45'); returns 11 <br> SELECT SECOND('22:11:45'); returns 45 |
| DATEDIFF(expr1, expr2) <br>TIMEDIFF(expr1, expr2)	| Returns expr1 - expr2 in number of days or time values, given expr1 and expr2 are date, time, or datetime values	| SELECT DATEDIFF('2013-03-10', '2013-03-04'); returns 6 <br>SELECT TIMEDIFF('10:00:00', '09:45:30'); returns 00:14:30 |

* Example: Select movies with release date after 2017 OR in November
```sql
SELECT *
FROM Movie
WHERE YEAR(ReleaseDate) > 2017 OR  MONTH(ReleaseDate) = 11;
```

## 3.3 Aggregate Functions
### 3.3.1 Aggregate Functions COUNT() MIN() MAX() SUM() AVG()
An aggregate function processes values from a set of rows and returns a summary value. Common aggregate functions are:
* COUNT() counts the number of rows in the set.
* MIN() finds the minimum value in the set.
* MAX() finds the maximum value in the set.
* SUM() sums all the values in the set.
* AVG() computes the arithmetic mean of all the values in the set.

Example:
```sql
-- Return count of number of rows with <column> > 5
SELECT COUNT(*)
FROM <table>
WHERE <column> > 5;

--- Return row with the MIN value
SELECT MIN(Salary)
FROM <table>;

-- Return total AVG of all columns
SELECT AVG(Salary)
FROM <table>
```
### 3.3.3 GROUP BY clause
* If you have duplicate column values ie country code, you can group results together
```sql
-- returns group CountryCode column with the sum off all populations for that code
SELECT CountryCode, SUM(Population)
FROM <table>
GROUP BY CountryCode;

-- Counts  how many rows exist in each group (with duplicate countrycode and districts exist)
SELECT CountryCode, District, COUNT(*)
FROM <table>
GROUP BY CountryCode, District;
```
### 3.3.5 HAVING Clause
* Used with GROUP BY clause to filter group results
```sql
SELECT CountryCode, SUM(Population)
FROM <table>
GROUP BY CountryCode
HAVING SUM(Population) > 23000000;

-- HAVING selects only groups that have a row count >=2
SELECT CountryCode, District, COUNT(*)
FROM <table>
GROUP BY CountryCode, District
HAVING COUNT(*) >= 2;

-- Returns the MAX releaseYear organized by  genre with count > 1
SELECT Genre, COUNT(*), MAX(ReleaseYear)
FROM Song
GROUP BY Genre
HAVING COUNT(*) >1;
```

### 3.3.8 Aggregate NULL Values
* Be careful NULL may result in unexpected results
* May ignore NULL values in calculations
* x + NULL = NULL so will be ignored in calculations
Aggregate functions ignore NULL values. Ex: SUM(Salary) adds all non-NULL salaries and ignores rows containing a NULL salary.

Aggregate functions and arithmetic operators handle NULL differently. Arithmetic operators return NULL when either operand is NULL. As a result, aggregate functions may generate surprising results when NULL is present. Ex: In the animations below, 
```SUM(Salary) + SUM(Bonus)``` is not equal to ```SUM(Salary + Bonus)```.


## 3.4 Join

* Join lets you join data from two tables to one result row

```sql
SELECT DepartmentName, EmployeeName
FROM <table1>, <table2>
WHERE Manager=ID;
```
* If there is a naming contention, use ```table1.name or table2.name```
* You can also use the ```AS``` keyword to reassign the alias
```sql
SELECT Department.Name AS dept_name,
       Employee.Name AS supervisor
FROM Department, Employee_table
WHERE Manager=ID;
```

### INNER and FULL Joins
* INNER JOIN selects only matching left and right table rows.
* FULL JOIN selects all left and right table rows, regardless of match
* In a FULL JOIN result table, unmatched left table rows appear with NULL values in right table columns, and vice versa.

The join clause appears between a FROM clause and an ON clause:

The FROM clause specifies the left table.
The INNER JOIN or FULL JOIN clause specifies the right table.
The ON clause specifies the join columns.
An optional WHERE clause follows the ON clause.

Join clauses are standard SQL syntax and supported by most relational databases. MySQL supports INNER JOIN but not FULL JOIN. For details of MySQL join syntax, see the link in 'Exploring further' below.

* INNER JOIN, no unmatched rows will show
```sql
SELECT Department.Name AS Team,
       Employee.Name AS Supervisor
FROM table1
INNER JOIN table2
ON Manager=ID;
```

* FULLJOIN, all unmatched rows will also show as NULL pairings if no match
```sql
SELECT Department.Name AS Team,
       Employee.Name AS Supervisor
FROM table1
FULL JOIN table2
ON Manager=ID;
```

#### LEFT and RIGHT Joins
In some cases, the database user wants to see unmatched rows from either the left or right table, but not both. To enable these cases, relational databases support left and right joins:

LEFT JOIN selects all left table rows, but only matching right table rows.
RIGHT JOIN selects all right table rows, but only matching left table rows.
An outer join is any join that selects unmatched rows, including left, right, and full joins.

* EXample LEft join:
* Result is LEFT_FIELD | NULL
```sql
SELECT Department.Name AS Team,
       Employee.Name AS Supervisor
FROM table1
LEFT JOIN table2
ON Manager=ID;
```
* EXample Rightjoin:
* Result is NULL | RIGHT_FIELD
```sql
SELECT Department.Name AS Team,
       Employee.Name AS Supervisor
FROM table1
RIGHT JOIN table2
ON Manager=ID;
```

#### Alternative joins UNION
Inner joins can be written without the JOIN keyword. Outer joins can be written with a UNION keyword instead of a JOIN keyword. UNION combines the results of two SELECT clauses into one result table:

For a left join, one SELECT returns matching rows and another returns unmatched left table rows (null results).

For a right join, one SELECT returns matching rows and another returns unmatched right table rows (NUll results.

For a full join, three SELECT clauses are necessary. One SELECT returns matching rows, another returns unmatched left table rows, and a third returns unmatched right table rows. The three results are merged with two UNION keywords.

Use of the JOIN keyword is good practice.Join queries written with UNION are complex and difficult to understand. LEFT JOIN, RIGHT JOIN, and FULL JOIN clarify join behavior and simplify queries.

```sql
SELECT Department.Name AS Team,
       Employee.Name AS Supervisor
FROM table1
LEFT JOIN table2
ON Manager=ID;
```
is the same as
```sql
SELECT Department.Name ,
       Employee.Name 
FROM table1, table2
WHERE Manager=ID;
UNION
SELECT DEpartment.name, NULL
FROM table 1
WHERE Manager IS NULL
  OR Manager NOT IN 
     (SELECT ID
       FROM Employee
       WHERE ID IS NOT NULL);
```

 ### INNER JOIN 
 * The query only returns rows for which faculty and department codes match. The inner join is written without a UNION keyword.
Correct

```sql
SELECT FacultyName, DepartmentName 
FROM Faculty, Department
WHERE Faculty.Code = Department.Code;
```

### Left Join
* The left table is Faculty. The first SELECT clause returns matching rows. The second SELECT clause returns unmatched Faculty rows. The UNION keyword merges matched and unmatched rows into one result table. Since Faculty.Code is a foreign key, OR Faculty.Code NOT IN
   (SELECT Code FROM Department WHERE CODE IS NOT NULL)
is unnecessary in the second WHERE clause.
```sql
SELECT FacultyName, DepartmentName 
FROM Faculty, Department
WHERE Faculty.Code = Department.Code
UNION
SELECT FacultyName, NULL
FROM Faculty
WHERE Faculty.Code IS NULL;
```

#### RIGHT JOIN
* The right table is Department. The first SELECT clause returns matching rows. The second SELECT clause returns unmatched Department rows. The UNION keyword merges matched and unmatched rows into one result table. Since Code is the primary key of Department, OR Department.Code IS NULL is unnecessary in the second WHERE clause.
```sql
SELECT FacultyName, DepartmentName 
FROM Faculty, Department
WHERE Faculty.Code = Department.Code
UNION
SELECT NULL, DepartmentName
FROM Department
WHERE Department.Code NOT IN
   (SELECT Code FROM Faculty WHERE Code IS NOT NULL);
```

#### FULL JOIN
* The first SELECT clause returns matching rows, the second returns unmatched Faculty rows, and the third returns unmatched Department rows. The UNION keyword merges matched and unmatched rows into one result table. Since Department.Code is a primary key and Faculty.Code is a foreign key, the second and third WHERE clauses are simplified.
  
```sql
SELECT FacultyName, DepartmentName 
FROM Faculty, Department
WHERE Faculty.Code = Department.Code
UNION
SELECT FacultyName, NULL
FROM Faculty
WHERE  Faculty.Code IS NULL
UNION
SELECT NULL, DepartmentName
FROM Department
WHERE Department.Code NOT IN 
   (SELECT Code FROM Faculty WHERE CODE IS NOT NULL);
```

## 3.6 Subqueries
* A subquery, sometimes called a nested query or inner query, is a query within another SQL query. The subquery is typically used in a SELECT statement's WHERE clause to return data to the outer query and restrict the selected results. The subquery is placed inside parentheses ().
*  The out SELECT statement uses a subquery to determine which language are used by a larger percentage of a country's population than Aruba's official language
*  Inner subquery is executed fist to get back the result to compare to the outer query ie. 5.3%
*  The subquery selects returns multiple values, but the outer query can only compare Percentage with a single value. Subqueries that produce more than one value or row are typically used with the IN operator in an outer query.
  
```sql
SELECT  Language, Percentage
FROM T1_CountryLanguage
WHERE Percentage >
    ( SELECT Percentage
    FROM CountryLanguage
    WHERE CountryCode = 'ABW' AND IsOfficial = 'T'
    );
```

### Subquery broken down
* In this search we want to find songs released after 1992
  
#### Query 1
```sql
SELECT *
FROM Song
WHERE ReleaseYear > 1992
ORDER BY ReleaseYear;
```
* Query 2
```sql
-- returns ReleaseYear=1992
SELECT ReleaseYear
FROM Song 
WHERE ID = 800;
```

* This combines Query1 + Query2 as a subquery
```sql
SELECT * 
FROM SONG
WHERE ReleaseYear > 
   (SELECT ReleaseYear
   FROM Song
   WHERE ID = 800
   )
ORDER BY ReleaseYear;
```

#### 3.6.4 Correlated subqueries
* A subquery is correlated when the subquery's WHERE clause references a column from the outer query
* The rows selected depend on what row is currently being examined by the outer query.

* Outer  query selecs rows from the City table. As each city row is selected, the subquery finds the average population based on the grouped countryCode and returns it for comparison with the outside query
```sql
SELECT Name, CountryCode, Population
FROM CITY C_Alias
WHERE Population >
    (SELECT AVG(Population)
     FROM City
     WHERE CountryCode = C_Alias.CountryCode);
```

#### 3.6.7 Exists operator
* Correlated subqueries commonly use the EXISTS operator, which returns TRUE if a subquery selects at least one row and FALSE if no rows are selected.
*  The NOT EXISTS operator returns TRUE if a subquery selects no rows and FALSE if at least one row is selected.
*  This means the EXIST clause is ```TRUE``` in the outer query so any country code from the inner query that matches will be returned
  
```sql
SELECT Name, CountryCode
FROM City C_alias
WHERE EXIST
    (SELECT *
    FROM CountryLanguage
    WHERE CountryCode = c_alias.CountryCode AND Percentage > 97);
```

### Example subquery with EXISTS
* The given SQL creates an Album and Song tables and inserts some albums and songs. Each song is associated with an album.

* The SELECT statement selects all albums with three or more songs. Run the query and verify the result table shows just the albums Saturday Night Fever and 21.

* Modify the GROUP BY clause to select albums with three or more songs by the same artist. Run the query and verify the result table shows just the album 21.
```sql
CREATE TABLE Album (
  ID INT,
  Title VARCHAR(60),
  ReleaseYear INT,
  PRIMARY KEY (ID)
);

INSERT INTO Album VALUES
  (1, 'Saturday Night Fever', 1977),
  (2, 'Born in the U.S.A.', 1984),
  (3, 'Supernatural', 1999),
  (4, '21', 2011);

CREATE TABLE Song (
  ID INT,
  Title VARCHAR(60),
  Artist VARCHAR(60),
  AlbumID INT,
  PRIMARY KEY (ID),
  FOREIGN KEY (AlbumID) REFERENCES Album(ID)
);

INSERT INTO Song VALUES
  (100, 'Stayin\' Alive', 'Bee Gees', 1),
  (101, 'More Than a Woman', 'Bee Gees', 1),
  (102, 'If I Can\'t Have You', 'Yvonne Elliman', 1),
  (200, 'Dancing in the Dark', 'Bruce Springsteen', 2),
  (201, 'Glory Days', 'Bruce Springsteen', 2),
  (300, 'Smooth', 'Santana', 3),
  (400, 'Rolling in the Deep', 'Adele', 4),
  (401, 'Someone Like You', 'Adele', 4),
  (402, 'Set Fire to the Rain', 'Adele', 4),
  (403, 'Rumor Has It', 'Adele', 4);

SELECT *
FROM Album
WHERE EXISTS 
  (SELECT COUNT(*)
   FROM Song
   WHERE AlbumID = Album.ID 
   GROUP BY AlbumID
   HAVING COUNT(*) >=3);
```

##### 3.6.9 Flattening Subqueries
* Many subqueries can be rewritten as a join. Most databases optimize a subquery and outer query separately, whereas joins are optimized in one pass. So joins are usually faster and preferred when performance is a concern.

* Replacing a subquery with an equivalent join is called flattening a query. The criteria for flattening subqueries are complex and depend on the SQL implementation in each database system. Most subqueries that follow IN or EXISTS, or return a single value, can be flattened. Most subqueries that follow NOT EXISTS or contain a GROUP BY clause cannot be flattened.

The following steps are a first pass at flattening a query:

1. Retain the outer query SELECT, FROM, GROUP BY, HAVING, and ORDER BY clauses.

2. Add INNER JOIN clauses for each subquery table.

3. Move comparisons between subquery and outer query columns to ON clauses.

4. Add a WHERE clause with the remaining expressions in the subquery and outer query WHERE clauses.

5. If necessary, remove duplicate rows with SELECT DISTINCT.

After this first pass, test the flattened query and adjust to achieve the correct result. Verify that the original and flattened queries are equivalent against a variety of data.

* Example this is written with Subqueries method

```sql
SELECT Name
FROM Country
WHERE Code IN
    (SELECT CountryCode
    FROM City
    WHERE Population > 1000000
    );
```

* Example of using INNER JOIN to flatten the query. THis will yeild the same results
*  Need to use the ```DISTINCT``` operator to eliminate duplicate rows
```sql
SELECT DISTINCT Name
FROM Country
INNER JOIN City ON Code = CountryCode
WHERE Population > 1000000;
```

#### 3.7 Complex queries - see 3.7.2 .sql example source file
Writing a complex query
Database users frequently create complex SQL queries that join data from multiple tables to answer business questions. Ex: A bookstore might ask, "Which books are selling best in summer?" and "What types of books do customers from the West Coast purchase?"

To create a complex query, a database user can employ the following strategy:

1. Examine a table diagram or other database summary to understand the tables and relationships.
2. Identify the tables containing the necessary data to answer the question.
3. Determine which columns should appear in the result table.
4. Write a query that joins the tables using the table's primary and foreign keys.
5. Break the problem into simple queries, writing one part of the query at a time.

* Joining tables 
```sql
SELECT S.CustID, C.State, S.BookID, B.Title, S.Quantity, S.UnitPrice * S.Quantity 
FROM Sale S
INNER JOIN Customer C ON C.ID = S.CustID
INNER JOIN Book AS B ON B.ID = S.BookID;
```

* Grouping by state and book
```sql
SELECT C.State, S.BookID, B.Title, SUM(S.Quantity) AS Quantity, SUM(S.UnitPrice * S.Quantity) AS TotalSales
FROM Sale S
INNER JOIN Customer C ON C.ID = S.CustID
INNER JOIN Book AS B ON B.ID = S.BookID 
GROUP BY C.State, S.BookID
```



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

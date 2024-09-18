## Lecture 3 - Special Operators and Clauses
#### 3.1
* 3.1 - IN
* 3.1.2 BETWEEN
* LIKE
* DISTINCT Clause
* ORDERY BY Clause

#### 3.2
* Numeric functions (Math)

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




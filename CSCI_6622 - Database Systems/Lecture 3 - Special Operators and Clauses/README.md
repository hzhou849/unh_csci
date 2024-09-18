## Lecture 3 - Special Operators and Clauses
* 3.1 - IN
* 3.2 BETWEEN
* LIKE
* DISTINCT Clause
* ORDERY BY Clause

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






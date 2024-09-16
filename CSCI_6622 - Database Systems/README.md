# MYSQL Examples

## Data_types
### Integers
```
- usage: Code INT UNSIGNED NOT NULL
```
| Symbol | Size | Notes: |
| ------ | ---- | ------ |
| TINYINT |	1 byte | Signed range: -128 to 127 Unsigned range: 0 to 255 | 
| SMALLINT |	2 bytes | Signed range: -32,768 to 32,767Unsigned range: 0 to 65,535 | 
| MEDIUMINT |	3 bytes | Signed range: -8,388,608 to 8,388,607Unsigned range: 0 to 16,777,215 | 
| INT |	4 bytes | Signed range: -2,147,483,648 to 2,147,483,647Unsigned range: 0 to 4,294,967,295 | 
| BIGINT |	8 bytes	 | igned range: -263 to 263 -1 Unsigned range: 0 to 264 -1 | 


### Decimals
| Symbol | Size | Notes: |
| ------ | ---- | ------ |
| Decimal |  dynamic | 	123.4 and -54.29685	DECIMAL(M,D) Varies depending on M and D	Exact decimal number where M = number of significant digits, D = number of digits after decimal point |
| FLOAT	| 4 bytes |	Approximate decimal numbers with range: -3.4E+38 to 3.4E+38 |
| DOUBLE | 8 bytes |	Approximate decimal numbers with range: -1.8E+308 to 1.8E+308 |

### Date time
| Symbol | Size | Notes: |
| ------ | ---- | ------ |
| Date and time |3 bytes |'1776-07-04 13:45:22'	DATE Format: YYYY-MM-DD. Range: '1000-01-01' to '9999-12-31' |
| TIME | 3 bytes | Format: hh:mm:ss |
| DATETIME | 5 bytes | Format: YYYY-MM-DD hh:mm:ss. Range: '1000-01-01 00:00:00' to '9999-12-31 23:59:59'. |


### Char & String
| Symbol | Size | Notes: |
| ------ | ---- | ------ |
| CHAR(N) | N bytes | Fixed-length string of length N; 0 ≤ N ≤ 255 |
| VARCHAR(N) |	Length of characters + 1 bytes | Variable-length string with maximum N characters; 0 ≤ N ≤ 65,535 |
| TEXT	| Length of characters + 2 bytes | Variable-length string with maximum 65,535 characters |

## NULL Rules
* Comparison operators return NULL when either operand is NULL, comparison operators cannot be used to select NULL values.
```Ex: SELECT * FROM Employee WHERE Salary = NULL; never returns any rows, because the WHERE clause is always NULL.```
* Instead, the IS NULL and IS NOT NULL operators must be used to select NULL values. Value IS NULL returns TRUE when the value is NULL. Value IS NOT NULL returns TRUE when the value is not NULL.
```sql
Ex: SELECT * FROM Employee WHERE Salary IS NULL
Ex: SELECT * FROM Employee WHERE Salary IS NOT NULL
```
### NULL Logic
TRUE AND TRUE is TRUE.
TRUE AND FALSE is FALSE.
TRUE AND NULL is NULL.
| x | Y | AND | OR |
| - | - | --- | -- |
| True | NULL | NULL | TRUE | 
| NULL | TRUE | NULL | TRUE |
| FALSE | NULL | FALSE | NULL | 
| NULL | FALSE | FALSE | NULL |
| NULL | NULL | NULL | NULL |

| x | NOTx |
| - | ---- |
| NULL | NULL |



## Create Tables
```mysql

-- Create column with auto-increment
-- In MySQL, AUTO_INCREMENT may be applied only to primary key columns.
CREATE TABLE Employee (
   ID        SMALLINT UNSIGNED AUTO_INCREMENT,
   Name      VARCHAR(60),
   BirthDate DATE,
   Salary    DECIMAL(7,2),
   PRIMARY KEY (ID)
);

-- Multiple/Composite Primary keys
PRIMARY KEY (ISOCode2, ISOCode3)

-- Example  CREATE TABLE statement here:
CREATE TABLE Product(
   ID INT,
   Name VARCHAR(40),
   ProductType VARCHAR(3),
   OriginDate DATE,
   Weight DECIMAL(6,1)
);

-- NOT NULL - prevents null entries in specified column
CREATE TABLE Department (
   Code      TINYINT UNSIGNED NOT NULL,
   Name      VARCHAR(20),
   ManagerID SMALLINT
);

-- INSERT data into new table
INSERT INTO Product (ID, Name, ProductType, OriginDate, Weight) VALUES 
  (100, 'Tricorder', 'TC', '2020-08-11', 2.4),
  (200, 'Food replicator', 'FOD', '2020-09-21', 54.2),
  (300, 'Cloaking device', 'CD', '2019-02-04', 177.9);

-- You can skip the INTO keyword 
INSERT <TABLE_NAME>
VALUES (val_col1, val_col2...val_col(n));

-- You can reorder the column inserts as long as you match declaration
INSERT INTO <TABLE_NAME> (col_C, col_A, Col_B)
VALUES (val_C, val_A, val_B)

SELECT *
FROM Product;
```

## ALTER TABLE
* Alter table statement adds, deletes for modifies columns on an existing table.
```sql
-- Add a new Colmun in existing table
ALTER TABLE TableName
ADD <ColumnName> <DataType>;

-- Change the exisitng column name
ALTER TABLE TableName
CHANGE <CurrColumnName> <NewColName> <NewCol_DataType>;

-- Delete a column from table
ALTER TABLE TableName
Drop <ColumnName>;
```
## Update Table
```sql
UPDATE TableName
SET Column1 = Value1, Column2 = Value2, ...
WHERE condition;
```

## Delete
```sql
DELETE FROM TableName 
WHERE condition;
```

## Truncate 
* The TRUNCATE statement deletes all rows from a table. TRUNCATE is nearly identical to a DELETE statement with no WHERE clause except for minor differences that depend on the database system.
```sql 
TRUNCATE TABLE TableName;
```

## Select statement
* This will return the sum of each rows of results
```sql
SELECT <col1> + <col2>
FROM MyTable

-- Limit the result rows returned
SELECT 2 * (col1 - col2)
FROM MyTable
LIMIT 100; 
```

## Arithmetic Operators
 -(unary) ex. -(-2); used for reversing a neg sign
| Precedence |	Operators |
| ---------- | --------- |
| 1 |	- (unary) |
| 2 | ^ |
| 3 |	* / % |
| 4 |	+ - (binary) |
| 5 |	= !=     <     >     <=     >= |
| 6 | NOT |
| 7 |	AND |
|8  |	OR |

```sql
--Example:
The expression evaluates to FALSE for the row.
Status = 'Platinum' AND (Quantity * UnitPrice + ShippingPrice) > 100.00
'Platinum' = 'Platinum' AND                  (4 * 15.00 + 7.50)                > 100.00
'Platinum' = 'Platinum' AND                  (   60.00    + 7.50)                > 100.00
'Platinum' = 'Platinum' AND                             67.50                        > 100.00
TRUE             AND                             67.50                        > 100.00
TRUE             AND                                             FALSE
FALSE
1. The expression includes column names Status, Quantity, UnitPrice, and ShippingPrice.
2. The expression is evaluated for a specific row. Column names are replaced with column values for the row.
3. Operators within parentheses have the highest precedence. * has higher precedence than + and is evaluated first.
4. + is the only remaining operator inside the parentheses, and is evaluated next.
5. = has higher precedence than AND. = has the same precedence as > but appears to the left. So = is evaluated next.
6. > has higher precedence than AND, and is evaluated next.
7. The expression evaluates to FALSE for the row.
```

## Foreign Keys
* A foreign key is a column, or group of columns, that refer to a primary key. The data types of the foreign and primary keys must be the same, but the names may be different. Unlike primary keys, foreign key values may be NULL and are not necessarily unique. However, a foreign key value that is not NULL must match some value of the referenced primary key.
* So Foreign key is when you re-use the primary key from table A in another table B

* FOreign Key constraint
```sql
CREATE TABLE TableName (
  . . .
  FOREIGN KEY (ColumnName) REFERENCES TableName (ColumnName),
  . . . 
);
```

## Referential integrity actions
* These auto update references when modifying a table with reference links
* For foreign key inserts and updates, MySQL supports only RESTRICT. Foreign key inserts and updates that violate referential integrity are automatically rejected.
* MySQL has several limitations on primary key updates and deletes:

RESTRICT is applied when the ON UPDATE or ON DELETE clause is omitted.
SET NULL cannot be used when a foreign key is not allowed NULL values.
SET DEFAULT is not supported in some MySQL configurations.

| Keyword | Usage |
| ------- | ----- |
| RESTRICT | rejects an insert, update, or delete that violates referential integrity. |
| SET NULL | sets invalid foreign keys to NULL. |
| SET DEFAULT | sets invalid foreign keys to the foreign key default value. |
| CASCADE | propagates primary key changes to foreign keys. |

```sql
CREATE TABLE Department (
   Code TINYINT UNSIGNED,
   Name VARCHAR(20),
   ManagerID SMALLINT UNSIGNED,
   PRIMARY KEY (Code),
   FOREIGN KEY (ManagerID) REFERENCES Employee(ID)
      ON DELETE SET NULL
      ON UPDATE CASCADE
);
```

# MYSQL Examples

## Section 2
* SELECT
* Data types
* Create tables
* Show table
* DELETE
* TRUNCATE
* UPDATE
* SELECT STATEMENTS
* Referential integrity actions
* Constraints

## SELECT
```sql
  SELECT <col1>, <col2>.... <col_n>
  FROM <myTable>
  WHERE <Condition> 
```
* To display your columns from table created:
```sql
SELECT * FROM <schema>.<new_table>;
```

```sql
SELECT 'BEFORE: ' AS '';
SELECT * FROM Horse;
UPDATE Horse
SET Height = 15.6
WHERE ID =2;

SELECT 'AFTER' AS '';
SELECT * FROM Horse;
```

## Data_types

### BIT
| Symbol | Size | Notes: |
| ------ | ---- | ------ |
| BIT(N) | N | A bit-value type. M indicates the number of bits per value, from 1 to 64. The default is 1 if M is omitted.|
| BINARY(M) | Fixed M | similar to CHAR[(M)] respectively, but store bytes instead of characters. |
| VARBINARY(M) | Variable | Similar to VARCHAR[(m)]; Stores bytes instead of characters.  |

### Booleans
| Symbol | Size | Notes: |
| ------ | ---- | ------ |
| BOOL, BOOLEAN | N/A | A boolean value FALSE= 0, TRUE≠ 0 |

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

## Print debug statements to terminal 
* If printout repeats use ```AS ''```
* 
```sql
-- Method 1
SELECT 'Hello World!' AS '';

-- Method 2
SET @my_var = 'My message';
SELECT @my_var;

-- Method 3
DECLARE counter INT DEFAULT 1;
WHILE counter <=5 DO
   SELECT CONCAT('Counter is at: ', counter);
   SET COUNTER = counter + 1;
END WHILE;
```

## Create Tables
* EXample Full table1: Create table with constraint checks
* --ID - integer with range 0 to 65535, auto increment, primary key
* RegisteredName - variable-length string with max 15 characters, NULL not allowed
* Breed - variable-length string with max 20 characters, must be one of the following: Egyptian Arab, Holsteiner, Quarter Horse, Paint, Saddlebred
* Height - number with 3 significant digits and 1 decimal place, must be ≥ 10.0 and ≤ 20.0
* BirthDate - date, must be ≥ Jan 1, 2015
* Example of ```compound PRIMARY KEY''' where you have ID + email as the key 
```sql

CREATE TABLE Horse (
    ID SMALLINT UNSIGNED AUTO_INCREMENT,
    RegisteredName VARCHAR(15) NOT NULL,
    Breed VARCHAR(20) CHECK (Breed IN('Egyptian Arab', 'Holsteiner', 'Quarter Horse', 'Paint', 'Saddlebred')),
    Height DECIMAL(3,1) CHECK (Height >=10.0 AND Height <=20.0),
    BirthDate DATE CHECK (BirthDate >= '2015-01-01'),
    Email VARCHAR(20) UNIQUE, 
    PRIMARY KEY (ID, email)
);

SHOW COLUMNS FROM Horse;
```
### Example2 table with foreign key and delete referencial integrity
The database contains a Horse table, with columns:
* ID - integer, primary key
* RegisteredName - variable-length string

The database contains a Student table, with columns:
* ID - integer, primary key
* FirstName - variable-length string
* LastName - variable-length string

Create a LessonSchedule table, with columns:
* HorseID - integer with range 0 to 65535, not NULL
* StudentID - integer with range 0 to 65535
* LessonDateTime - date/time, not NULL
* (HorseID, LessonDateTime) is the primary key

Create the following foreign key constraints on LessonSchedule columns:
* HorseID references Horse. When an ID is deleted from Horse, matching LessonSchedule rows are deleted.* StudentID references Student. When an ID is deleted from Student, matching StudentID's are set to NULL.
```sql
CREATE TABLE LessonSchedule (
    HorseID SMALLINT UNSIGNED NOT NULL,
    StudentID SMALLINT UNSIGNED,
    LessonDateTime DATETIME NOT NULL,
    PRIMARY KEY(HorseID, LessonDateTime),
    FOREIGN KEY (HorseID) REFERENCES Horse (ID)
        ON DELETE CASCADE,
    FOREIGN KEY (StudentID) REFERENCES Student(ID)
        ON DELETE SET NULL
);

SHOW COLUMNS FROM LessonSchedule;
```

* Example1: Simple table
```mysql
-- Create column with auto-increment
-- In MySQL, AUTO_INCREMENT may be applied only to primary key columns.
USE <database_schema>
CREATE TABLE IF NOT EXISTS Employee (
   ID        SMALLINT UNSIGNED AUTO_INCREMENT,
   Name      VARCHAR(60) CHECK (Name IN ('G', 'PG', 'PG-13', 'R')),,
   BirthDate DATE,
   Salary    DECIMAL(7,2),
   PRIMARY KEY (ID)
);

SHOW TABLES;
SHOW COLUMNS FROM <my_table>;

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
## SHOW TABLE/COLUMNS
* Print the table to terminal
```mysql
SHOW TABLES;
SHOW COLUMNS FROM <my_table>;
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
``sql
UPDATE lab_practice_test.<table> 
SET `release_year` = '2001' 
WHERE (<primary_key_film_id> = '2');
```


## Delete
* Slower will track records, but is expensive
```sql
DELETE FROM TableName 
WHERE condition;
```
EXAMPLE:
```sql
DELETE FROM <table>
WHERE CustomerName='This_person';
```

## Truncate 
* Faster than delete because it doesn't log the deletion *CANNOT ROLLBACK!
* The TRUNCATE statement deletes all rows from a table. TRUNCATE is nearly identical to a DELETE statement with no WHERE clause except for minor differences that depend on the database system.
```mysql 
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

## Primary Keys / COmposite keys
* Primary key should be unique within the table
* if the primary key alone cannont be enough of a unique identifier (as foreign key) you may required a second key to make the records unique.
```sql
ID INT, 
Email VARCHAR(20) UNIQUE, 
PRIMARY KEY (ID, email)
```


## Foreign Keys
* A foreign key is a column, or group of columns, that refer to a primary key. The data types of the foreign and primary keys must be the same, but the names may be different. Unlike primary keys, foreign key values may be NULL and are not necessarily unique. However, a foreign key value that is not NULL must match some value of the referenced primary key.
* So Foreign key is when you re-use the primary key from table A in another table B

* FOreign Key constraint
```sql
CREATE TABLE Employee (
   ID             INT,
   Name           VARCHAR(20) NOT NULL,
   DepartmentCode INT DEFAULT 999,
   PRIMARY KEY (ID),
   FOREIGN KEY (DepartmentCode) REFERENCES Department (Code)
);
```
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
| RESTRICT | ex. ON DELETE RESTRICT; rejects an insert, update, or delete that violates referential integrity. |
| SET NULL | sets invalid foreign keys to NULL. |
| SET DEFAULT | sets invalid foreign keys to the foreign key default value. |
| CASCADE | Propagates primary key changes to foreign keys. If primary key is DELETED, rows containing matching foreign keys are deleted; UPDATE - matching foreign keys are updated to the same value |

```sql
CREATE TABLE Department (
   Code TINYINT UNSIGNED,
   Name VARCHAR(20),
   ManagerID SMALLINT UNSIGNED,
   PRIMARY KEY (Code),
   FOREIGN KEY (ManagerID) REFERENCES Employee(ID)
      ON DELETE SET NULL -- On delete, foreign keys will default to NULL
      ON UPDATE CASCADE -- on update, foreign keyss will update to new value
);
```
## CONSTRAINTS
### Unique Constraint
```UNIQUE (ManagerID, Appointment)```
* Means this combination of ManagerID and Appointment must be unique
```sql
CREATE TABLE Department (
   Code        TINYINT UNSIGNED,

--*** Unique can be placed here too
   Name        VARCHAR(20) UNIQUE,

   ManagerID   SMALLINT,
   Appointment DATE,
   PRIMARY KEY (Code),
   UNIQUE (ManagerID, Appointment)
);
```

### CHECK Constraint
* Used when creating tables
```sql
CREATE TABLE Department (
   Code          TINYINT UNSIGNED,
   Name          VARCHAR(20),
   ManagerID     SMALLINT,
   AdminAssistID SMALLINT,
   Size          VARCHAR(6) CHECK (Size IN ('small', 'medium', 'large')),
   PRIMARY KEY (Code),
   CHECK (ManagerID >= 1000 AND ManagerID <> AdminAssistID) 
);
```

### MySQL Constraint names
* The MySQL statement SHOW CREATE TABLE TableName returns the CREATE TABLE statement for TableName. The statement shows all CONSTRAINT ConstraintName clauses but does not show default constraint names.

The following query displays all names of constraints on TableName, including default names:
Key_Column_Usage is a table from the Information_Schema system database. Other Key_Column_Usage columns contain additional constraint details. Ex: Referenced_Table_Name and Referenced_Column_Name provide information about foreign key constraints.

```sql
SELECT Column_Name, Constraint_Name
FROM Information_Schema.Key_Column_Usage
WHERE Table_Name = 'TableName';

CREATE TABLE Department (
   Code TINYINT UNSIGNED,
   Name VARCHAR(20),
   ManagerID SMALLINT,
   CONSTRAINT UniqueNameMgr  UNIQUE (Name,  ManagerID),
   PRIMARY KEY (Code)
);

-- Example 2
CONSTRAINT CheckPopulation CHECK (PopDensity < Population)
DROP CHECK CheckPopulation
```

### Add / Drop Constraints
* Use in conjuction with ```ALTER TABLE```
* Adding a constraint fails when the table contains data that violates the constraint.

| Command | 
| ------- |
| ADD [CONSTRAINT ConstraintName] PRIMARY KEY (Column1, Column2 ...) |
| ADD [CONSTRAINT ConstraintName] FOREIGN KEY (Column1, Column2 ...) REFERENCES TableName (Column) |
| ADD [CONSTRAINT ConstraintName] UNIQUE (Column1, Column2 ...) |
| ADD [CONSTRAINT ConstraintName] CHECK (expression) |

* Example: Adds a constraint called MgrIDCheck to the existing table to ensure ManagerID is 2000 or greater
```sql
ALTER TABLE <my_table>
ADD CONSTRAINT MgrIDCheck CHECK (ManagerID >= 2000);
```
* Dropping a table fails when a foreign key constraint refers to the table's primary key. Before dropping the table, either the foreign key constraint or the foreign key table must be dropped.
DROP PRIMARY KEY
DROP FOREIGN KEY ConstraintName
DROP INDEX ConstraintName (drops UNIQUE constraints)
DROP CHECK ConstraintName
DROP CONSTRAINT ConstraintName (drops any named constraint)
* Example Drop: Drop the UNIQUE constraint called UniqueNameMgr from existing table

```sql
ALTER TABLE <my_table>
DROP INDEX <constraint_name>
--or 
DROP CONSTRAINT <constraint_name>
```

#### DEFAULT
```sql
CREATE TABLE Student(
    ID SMALLINT UNSIGNED AUTO_INCREMENT,
    State CHAR(2) NOT NULL DEFAULT 'TX',
    Email VARCHAR(30 ) UNIQUE,

    PRIMARY KEY (ID)
);
```

* ALTER TABLE with new default values
```sql
ALTER TABLE Persons
ALTER City SET DEFAULT 'Sandnes';
```

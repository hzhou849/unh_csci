# MYSQL Examples

## Data_types
### Integers
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


## Create Tables
```mysql
-- Example  CREATE TABLE statement here:
CREATE TABLE Product(
   ID INT,
   Name VARCHAR(40),
   ProductType VARCHAR(3),
   OriginDate DATE,
   Weight DECIMAL(6,1)
);

-- INSERT data into new table
INSERT INTO Product (ID, Name, ProductType, OriginDate, Weight) VALUES 
  (100, 'Tricorder', 'TC', '2020-08-11', 2.4),
  (200, 'Food replicator', 'FOD', '2020-09-21', 54.2),
  (300, 'Cloaking device', 'CD', '2019-02-04', 177.9);

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

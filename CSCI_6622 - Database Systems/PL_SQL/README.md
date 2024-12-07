## PL SQL

## Print string with variables
```sql
-- Create and assign the variable
SET @_currentSchema := (SELECT DATABASE());
SELECT CONCAT('Selected Schema:',  @_currentSchema);
```

## IF Statement
```sql
-- SELECT IF(<condition>, <true>, <false>);
-- Example true, with LIKE and wildcard matching %:
SELECT IF(@_currentSchema LIKE 'final%', 
    'true', 
    'falseadfasdf'); 

-- Example False:
SELECT IF(@_currentSchema = '%final', 
    'statement is true', 
    'Statement is falseadfasdf');
```


## 
Figure 9.3.3: DECLARE statement.
DECLARE VariableName Type [ DEFAULT Value ];

Feedback?
The SET statement assigns a variable with an expression. The variable must be declared prior to the SET statement, and the expression may be any valid SQL expression.

Figure 9.3.4: SET statement.
SET VariableName = <expression>;

Feedback?
The IF statement is similar to statements in other programming languages. The statement includes a logical expression and a statement list. If the expression is true, the statements in the list are executed. If the expression is false, the statements are ignored.

IF statements have optional ELSEIF and ELSE clauses. ELSEIF and ELSE clauses are executed when the expression in the IF clause is false, as in other programming languages.

Figure 9.3.5: IF statement.
IF expression THEN statement list
[ ELSEIF expression THEN statement list ]
[ ELSE StatementList ]
END IF;

Feedback?
The WHILE statement also includes an expression and a statement list. The statement list repeatedly executes as long as the expression is true. When the expression is false, the WHILE statement terminates, and the statement following END WHILE executes.

Figure 9.3.6: WHILE statement.
WHILE expression DO
   statement list
END WHILE;

## Cursors
A cursor is a special variable that identifies an individual row of a result table. Cursors are necessary to process queries that return multiple rows. Cursor syntax in procedural SQL is similar to embedded SQL:

DECLARE CursorName CURSOR FOR Statement creates a cursor named CursorName that is associated with the query Statement. The Statement may not have an INTO clause.

DECLARE CONTINUE HANDLER FOR NOT FOUND Statement specifies a Statement that executes when the cursor eventually moves past the last row and cannot fetch any more data. Reading data from a cursor is performed within a loop, so the Statement usually sets a variable indicating the loop should terminate.

OPEN CursorName executes the query associated with CursorName and positions the cursor before the first row of the result table. Multiple cursors with different names can be open at the same time.

FETCH FROM CursorName INTO variable [, variable, ... ] advances CursorName to the next row of the result table and copies selected values into the variables. The number of INTO clause variables must match the number of SELECT clause columns.

CLOSE CursorName releases the result table associated with the cursor.

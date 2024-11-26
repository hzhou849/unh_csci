## PL SQL

## Cursors
A cursor is a special variable that identifies an individual row of a result table. Cursors are necessary to process queries that return multiple rows. Cursor syntax in procedural SQL is similar to embedded SQL:

DECLARE CursorName CURSOR FOR Statement creates a cursor named CursorName that is associated with the query Statement. The Statement may not have an INTO clause.

DECLARE CONTINUE HANDLER FOR NOT FOUND Statement specifies a Statement that executes when the cursor eventually moves past the last row and cannot fetch any more data. Reading data from a cursor is performed within a loop, so the Statement usually sets a variable indicating the loop should terminate.

OPEN CursorName executes the query associated with CursorName and positions the cursor before the first row of the result table. Multiple cursors with different names can be open at the same time.

FETCH FROM CursorName INTO variable [, variable, ... ] advances CursorName to the next row of the result table and copies selected values into the variables. The number of INTO clause variables must match the number of SELECT clause columns.

CLOSE CursorName releases the result table associated with the cursor.

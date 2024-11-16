# 6. Savepoints and rollback and start transactions

```sql
-- Initialize database
source Initialize.sql


-- Your SQL statements go here


-- 1. Start a transaction
START TRANSACTION;


-- 2. Insert new actor 'Nicole Streep'
INSERT INTO actor(actor_id, first_name, last_name, last_update) VALUES
(999, 'NICOLE', 'STREEP', '2021-06-01 12:00:00');


-- 3. Set a savepoint
SAVEPOINT first_sp;


-- 4. Delete all actor with first name 'CUBA'
DELETE FROM actor WHERE first_name = 'CUBA';


-- 5. SELECT all actors
SELECT * FROM actor;


-- 6. Rollback to the savepoint 'first_sp'
ROLLBACK TO first_sp;


-- 7. SELECT all actors 2nd time - Should see CUBA now
SELECT * from actor;


-- 8. Commit the transaction
COMMIT;
```

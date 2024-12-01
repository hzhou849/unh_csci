LAB 01 -ITEC 3220 Designing Databases

--CREATE TABLE
CREATE TABLE CUSTOMER1 (
customer_id		INTEGER,
customer_name	VARCHAR2 (25)	NOT NULL,
street			VARCHAR2 (25)	NOT NULL,
city 			VARCHAR2 (15)	NOT NULL,
state			VARCHAR2 (15)	NOT NULL,
balance			NUMBER 	(8,2)	NOT NULL,
credit_limit	NUMBER (8,2)	NOT NULL,
rep_number		INTEGER,
primary key 	(customer_id)
);



DECLARE
i_customer_id :=0;

BEGIN
	
	INSERT INTO customer VALUES (
		1, 'lucifer, morningstar',
		'21 Jump St.', 'Toronto',
		'CA', 5000.00, 
		1000.00, 902
	);

	INSERT INTO customer VALUES(
		1, 'john smith', 
		'123 finch ave.', 'Toronto'
		'ON', 99.99,
		129.99, 901
	);


END;
	
	SELECT a.customer_id, a.customer_name 
	FROM CUSTOMER a
	WHERE  a.city = 'Toronto';

	SELECT a.customer_id, a.customer_name
	from CUSTOMER a
	WHERE a.credit_limit > a.balance;

	SELECT a.customer_id, a.customer_name, (a.balance - a.credit_limit) 
	FROM customer a;

	SELECT COUNT(*), MAX(Balance)
	From customer;

	SELECT rep_number, (AVG)

/

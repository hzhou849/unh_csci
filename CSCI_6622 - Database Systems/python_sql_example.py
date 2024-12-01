import mysql.connector
import sys
import time

# Create a database connection
def create_connection():
    """ 
    Create a connection to 'zybooksdb' database 
    :return: Connection object
    """

    # YOUR CODE HERE
    try:
        reservationConnection = mysql.connector.connect(
            user='root',
            #password='password123'
            host='127.0.0.1',
            database='zybooksdb'
        )
    except mysql.connector.Error as err:
        if err == 1:
            print ("error")
        # if err.errno = errorCode.ER_ACCESS_DENIED_ERROR:
        #     print('Invalid credentials')
        # elif err.errno == errorcode.ER_BAD_DB_ERROR:
        #     print('Database not found')
        # else:
        #     print('Cannot connect to database: ', err)

    return reservationConnection


# Create Horse table
def create_table(conn):
    """ 
    Create Horse table
    :param conn: Connection object
    :return: Nothing
    """
  
    # YOUR CODE HERE

    # Create a cursor object
    cursor = conn.cursor()

    # CHECk for tables and drop if exist
    cursor.execute("SHOW TABLES") 
    print(cursor.fetchall())
    cursor.execute("DROP TABLE IF EXISTS Horse")
    print("Table dropped!")

    # Create Horse Table per requirements
    sqlCmd = '''CREATE TABLE Horse(
        ID INT,
        Name VARCHAR(30),
        Breed VARCHAR(30),
        Height DOUBLE,
        BirthDate varchar(10),
        PRIMARY KEY (ID))'''

    cursor.execute(sqlCmd)


    # Close the cursor object
    cursor.close()



# Insert row to Horse table using paramenters
def insert_horse(conn, data):
    """
    Create a new row in Horse table
    :param conn: Connection object
    :param data: Tuple of values to be inserted in row
    :return: Nothing
    """
   
    # YOUR CODE HERE
    
    # Create cursor object
    cursor = conn.cursor()

    # Prepare the sql query to INSERT data record into table

    # Method 1 - with literals
    #sqlQuery = """INSERT INTO HORSE( ID, Name, Breed, Height, BirthDate)
    #            VALUES (1, 'Musty', 'Mustang',15.1, '2015-02-10' )"""

    # Method 2 - using placeholds %s
    sqlQuery = """INSERT INTO HORSE( ID, Name, Breed, Height, BirthDate)
            VALUES (%s, %s, %s, %s, %s )"""
    
    # execute the command, since data is provided for us as a tuple, we can just pass it
    # data_tuple =(1, 'Babe', 'Quarter horse', 15.3, '2015-02-10')
    cursor.execute(sqlQuery, data)
    conn.commit()

    # close the cursor object after transactions
    cursor.close()

    

# Select and print all rows of Horse table
def select_all_horses(conn):
    """
    Query all rows in the Horse table
    :param conn: Connection object
    :return: Nothing
    """
  
    # YOUR CODE HERE
    
    # Create cursor object
    cursor = conn.cursor()

    # sql query to select all
    sqlQuery = '''SELECT * FROM Horse'''

    # Execute the query
    print("Executing sqlQuery to SELECT records...")
    cursor.execute(sqlQuery)

    # Fetch all rows from the query
    for row in cursor.fetchall():
        # You can also do row[0], row[1]... for specific fields only
        print(row)
    
    cursor.close()

# DO NOT MODIFY main
if __name__ == '__main__':

    # Create database connection
    conn = create_connection()
    if conn is None:
        exit()

    # Create Horse table
    create_table(conn)
    
    # Insert row to Horse table
    horse_data = (1, "Babe", "Quarter Horse", 15.3, "2015-02-10")
    insert_horse(conn, horse_data)

    # Select and print all Horse table rows
    select_all_horses(conn)

    conn.close()

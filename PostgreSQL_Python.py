import psycopg2 as pg2 

#Create a connection with PostgreSQL with your username and password
conn=pg2.connect(database='dvdrental',user='postgres',password='***********')

#Establish connection and start cursor to be ready to query
cur=conn.cursor()
cur.execute('SELECT * FROM customer')

print(cur.fetchone()) #fetchmany(), fetchall()

#To save and index results, assign it to a variable
data = cur.fetchmany(10)

print(data)

# **Inserting Information**
query1 = '''
        CREATE TABLE new_table (
            userid integer
            , tmstmp timestamp
            , type varchar(10)
        );
        '''

cur.execute(query1)

# commit the changes to the database
cur.commit()

# Don't forget to close the connection!
# killing the kernel or shutting down juptyer will also close it
conn.close()

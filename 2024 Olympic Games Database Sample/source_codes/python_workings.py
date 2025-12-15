import mysql.connector

conn = mysql.connector.connect(host='localhost',database='Olympics24_21323157',user='admin',password='admin')
cursor = conn.cursor()

new_country = ('SPA', 'Spain')

# Insert the new country into the Country table
insert_query = "INSERT INTO Country (countryCode, name) VALUES (%s, %s)"
cursor.execute(insert_query, new_country)


print('After Insertion')
select_query = "SELECT * FROM Country WHERE countryCode LIKE 'S%'"
cursor.execute(select_query)

results = cursor.fetchall()
for row in results:
    print(row)


# Update the Spain entry 
update_country = ('Spanish Republic', 'SPA')

update_query = "UPDATE Country SET name = %s WHERE countryCode = %s"
cursor.execute(update_query, update_country)

print('\nAfter Update')
select_query = "SELECT * FROM Country WHERE countryCode LIKE 'S%'"
cursor.execute(select_query)

results = cursor.fetchall()
for row in results:
    print(row)
    

delete_country = ('SPA',)

# Delete the Spain entry
delete_query = "DELETE FROM Country WHERE countryCode = %s"
cursor.execute(delete_query, delete_country)

print('\nAfter Deletion')
select_query = "SELECT * FROM Country WHERE countryCode LIKE 'S%'"
cursor.execute(select_query)

results = cursor.fetchall()
for row in results:
    print(row)
    
    
cursor.close()
conn.close()

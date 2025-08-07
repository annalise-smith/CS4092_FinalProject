import mysql.connector
from datetime import date

print("Script started")
try:
    print("Trying to connect to database...")
    db = mysql.connector.connect(
        host="localhost",
        user="annalise.smith05@gmail.com",
        password="TemporaryForCla$$1",
        database="ecommerce"
    )
    print("Connected!")

    cursor = db.cursor()
    cursor.execute("SHOW TABLES;")
    print("Connected successfully. Tables in database:")
    for table in cursor:
        print(table)

except mysql.connector.Error as err:
    print("Connection error:", err)

except Exception as e:
    print("Unexpected error:", e)
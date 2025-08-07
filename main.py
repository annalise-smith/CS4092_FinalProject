import mysql.connector
from datetime import date

try:
    db = mysql.connector.connect(
        host="localhost",
        user="annalise.smith05@gmail.com",
        password="TemporaryForCla$$1",
        database="ecommerce"
    )

    cursor = db.cursor()
    cursor.execute("SHOW TABLES;")
    print("Connected successfully. Tables in database:")
    for table in cursor:
        print(table)

except mysql.connector.Error as err:
    print("Connection error:", err)
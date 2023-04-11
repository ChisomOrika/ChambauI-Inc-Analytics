import csv
import psycopg2
from psycopg2 import sql
import os
import config
import boto3
from botocore import UNSIGNED
from botocore.client import Config


# AWS S3 bucket configuration
s3 = boto3.client('s3', config=Config(signature_version=UNSIGNED))
bucket_name = config.bucket_name
folder_prefix = config.folder_prefix


# Connect to PostgreSQL
def connect_postgres():
    return psycopg2.connect(
    host=config.db_host,
    port=config.db_port,
    user=config.db_user,
    password=config.db_password,
    database=config.db_name
    )


# Extract data from S3 bucket
def extract_data():
    conn = connect_postgres()
    for file_name in ['orders.csv', 'reviews.csv', 'shipment_deliveries.csv']:
        # Download the file from S3
        s3.download_file(bucket_name, folder_prefix + file_name, file_name)

        # Load the file into PostgreSQL
        with open(file_name, 'r') as file:
            cursor = conn.cursor()

            # Get the headers from the file
            headers = next(csv.reader(file))

            # Move the cursor back to the start of the file
            file.seek(0)

            # Copy the data from the file to the staging table
            cursor.copy_expert(sql.SQL("COPY {}.{} ({}) FROM STDIN WITH CSV HEADER DELIMITER ',';").format(
                sql.Identifier(config.staging_schema_name),
                sql.Identifier(file_name.split('.')[0]),
                sql.SQL(', ').join(map(sql.Identifier, headers))
            ), file)

            # Close the cursor
            cursor.close()

            # Commit the changes
            conn.commit()

        # Delete the file from local disk
        os.remove(file_name)

    # Close the PostgreSQL connection
    conn.close()

if __name__ == '__main__':
    extract_data()
    print("process is done")
else:
    print('not executed')




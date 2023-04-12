import psycopg2
import boto3
from io import StringIO
from botocore.config import Config
from botocore import UNSIGNED
import config


# S3 credentials
s3_bucket_name = 'd2b-internal-assessment-bucket'
s3_folder_name = 'analytics_export/{}'.format(config.db_user)

# connect to the database
conn = psycopg2.connect(
    host=config.db_host,
    port=config.db_port,
    user=config.db_user,
    password=config.db_password,
    database=config.db_name
)

# create a cursor object
cur = conn.cursor()

# export tables
tables = ['best_performing_product', 'agg_shipments', 'agg_public_holiday']

for table in tables:
    # create a query to export the table to a CSV file
    query = "COPY {}.{} TO STDOUT WITH CSV HEADER".format(config.analytics_schema_name, table)
    
    # execute the query and get the result
    cur.copy_expert(query, StringIO())
    csv_data = StringIO().getvalue()
    
    # create an S3 client and upload the CSV file to the S3 bucket
    s3_client = boto3.client('s3', config=Config(signature_version=UNSIGNED))
    s3_file_name = '{}/{}.csv'.format(s3_folder_name, table)
    s3_client.put_object(Bucket=s3_bucket_name, Key=s3_file_name, Body=csv_data)
    
# close the cursor and connection
cur.close()
conn.close()

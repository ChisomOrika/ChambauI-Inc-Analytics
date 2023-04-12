# Project Overview
=======

This project is focused on utilizing dbt, a data transformation tool and Python to build a data pipeline that simulates Chambau datasets. The datasets contain information about orders, deliveries and reviews. The pipeline will transform this raw data into a format that is suitable for analysis and reporting in downstream applications. 

### Tech stack and functions

DBT: For data cleaning and transformation <br>
Python: Data extraction and loading <br>
Amazon s3: Data lake <br>
Postgres : Data warehouse <br>
PowerBI : BI tool for developing dashboard <br>

### ER of Data Warehouse

![schema of dim and fact tables](https://user-images.githubusercontent.com/90322381/231607826-2a640b1a-2c04-4ed2-b16c-98a44fe5ef1d.png)



### Workflow Architecture


![Chambau workflow](https://user-images.githubusercontent.com/90322381/231427074-8120f8b7-4909-4c77-bd4d-2f70e00c5bc5.png)


### Project Structure

- dbt_project.yml
- extractload
  - export_to_s2.py
  - extract_from_s3.py
- models
  - src
    - src_dates.sql
    - src_deliveries.sql
    - src_orders.sql
    - src_reviews.sql
    - src_products.sql
  - analysis
    - undelivered_shipments.sql
    - early_shipments.sql
    - late_shipments.sql
    - highest_review_product
    - best_performing_product
    - agg_shipments
    - agg_public_holiday
  - schema.yml
  - source_yml
- data
  - hosts.csv
  - listings.csv
  - reviews.csv <br>

* dbt_project.yml: The project configuration file that defines the settings for dbt.
* extractload/: The directory that contains the python file for extrating from s3 and exporting the analysis back to s3.
* models/src: The directory that contains the models for the staging area.
* models/analytics: The directory that contains the models for the analysis area.
* model/source.yml: is a config file to define the sources of data, schema and tables that used in the project. 
* model/schema.yml: contains a list of models, configuration details such as the SQL code for the model, its dependencies, and its column definitions.



### DBT Workflow

![chambau workflow dbt](https://user-images.githubusercontent.com/90322381/231587860-aa5b2a42-0fe0-4551-812f-47caa667ccc0.png)


### Getting Started
* Clone the repository: git clone https://github.com/ChisomOrika/Chambau-Inc-Analytics.git
* Install dbt: pip install dbt-postgres
* Load the raw data into your database staging area: run the extractload in your terminal
* Setup the data warehouse, grant the neccessary permissions and connect it to dbt in the profiles.yml in your directory. This can be retrieved using the following command cat ~/.dbt/profiles.yml
* Run make init to inialize dbt structure for your project
* Transform the data and load it into your analysis area: dbt run --models
* Run make docs to generate the project documentation and make serve to deploy this documentation to a webserver accessed at port 8080


### Resources:
- Learn more about dbt [in the docs](https://docs.getdbt.com/docs/introduction)
- Check out [Discourse](https://discourse.getdbt.com/) for commonly asked questions and answers
- Join the [chat](https://community.getdbt.com/) on Slack for live discussions and support
- Find [dbt events](https://events.getdbt.com) near you
- Check out [the blog](https://blog.getdbt.com/) for the latest news on dbt's development and best practices
>>>>>>> e5e35c7 (add project files)

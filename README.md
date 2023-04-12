# Project Overview
=======

This project is focused on utilizing dbt, a data transformation tool and Python to build a data pipeline that simulates Chambau datasets. The datasets contain information about orders, deliveries and reviews. The pipeline will transform this raw data into a format that is suitable for analysis and reporting in downstream applications. 

### Tech stack and functions

DBT: For data cleaning and transformation <br>
Python: Data extraction and loading <br>
Amazon s3: Data lake <br>
Postgres : Data warehouse <br>
PowerBI : BI tool for developing dashboard <br>

### Workflow Architecture


![Chambau workflow](https://user-images.githubusercontent.com/90322381/231427074-8120f8b7-4909-4c77-bd4d-2f70e00c5bc5.png)

### How to run the project
* Create a project folder and cd into this folder

* Run make setup on your terminal to setup dbt in your current directory

* Run make init to inialize dbt structure for your project

* Setup the data warehouse, grant the neccessary permissions and connect it to dbt in the profiles.yml in your directory. This can be retrieved using the following command cat ~/.dbt/profiles.yml

* Run make docs to generate the project documentation and make serve to deploy this documentation to a webserver accessed at port 8080


### DBT Workflow

![chambau workflow dbt](https://user-images.githubusercontent.com/90322381/231587860-aa5b2a42-0fe0-4551-812f-47caa667ccc0.png)

- dbt_project.yml
- models
  - src
    - src_dates.sql
    - src_deliveries.sql
    - src_orders.sql
    - src_reviews.sql
    - src_p
  - analysis
    - hosts.sql
    - listings.sql
    - reviews.sql
- data
  - hosts.csv
  - listings.csv
  - reviews.csv <br>
`
hjklklo
`|hyiooui
`|joopppp
`

dbt_project.yml: The project configuration file that defines the settings for dbt.
models/src: The directory that contains the models for the staging area.
models/analytics: The directory that contains the models for the analysis area.


### Getting Started
* Clone the repository: git clone https://github.com/ChisomOrika/Chambau-Inc-Analytics.git
* Install dbt: pip install dbt
* Configure your database connection settings in dbt_project.yml
* Load the raw data into your database staging area: run the extractload in your terminal
* Transform the data and load it into your analysis area: dbt run --models


### Resources:
- Learn more about dbt [in the docs](https://docs.getdbt.com/docs/introduction)
- Check out [Discourse](https://discourse.getdbt.com/) for commonly asked questions and answers
- Join the [chat](https://community.getdbt.com/) on Slack for live discussions and support
- Find [dbt events](https://events.getdbt.com) near you
- Check out [the blog](https://blog.getdbt.com/) for the latest news on dbt's development and best practices
>>>>>>> e5e35c7 (add project files)

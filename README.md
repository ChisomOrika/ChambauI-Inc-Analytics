<<<<<<< HEAD
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

<img width="874" alt="graph" src="https://user-images.githubusercontent.com/90322381/231490229-87901148-2c65-4ee2-ba2c-947376e72f60.png">

<img width="950" alt="chambau dbt workflow" src="https://user-images.githubusercontent.com/90322381/231496975-22b2a53d-78a5-4dcf-b2db-500ac5bf9f0b.png">


### Resources:
- Learn more about dbt [in the docs](https://docs.getdbt.com/docs/introduction)
- Check out [Discourse](https://discourse.getdbt.com/) for commonly asked questions and answers
- Join the [chat](https://community.getdbt.com/) on Slack for live discussions and support
- Find [dbt events](https://events.getdbt.com) near you
- Check out [the blog](https://blog.getdbt.com/) for the latest news on dbt's development and best practices
>>>>>>> e5e35c7 (add project files)

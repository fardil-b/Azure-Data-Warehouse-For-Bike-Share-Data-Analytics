# Azure-Data-Warehouse-For-Bike-Share-Data-Analytics
# Building an Azure Data Warehouse for Bike Share Data Analytics - using Azure Synapse Analytics


Divvy is a bike sharing program in Chicago, Illinois USA that allows riders to purchase a pass at a kiosk or use a mobile application to unlock a bike at stations around the city and use the bike for a specified amount of time. The bikes can be returned to the same station or to another station. The City of Chicago makes the anonymized bike trip data publicly available for projects like this where we can analyze the data. The dataset looks like this:

![image](https://user-images.githubusercontent.com/61830624/195534057-25902854-44d5-48ef-82be-272e30d419a9.png)

The goal of this project is to develop a data warehouse solution using Azure Synapse Analytics. We will:
- Design a star schema based on the business outcomes listed below;
- Import the data into Synapse;
- Transform the data into the star schema;
- and finally, view the reports from Analytics.

The business outcomes we are designing for are as follows:
1. Analyze how much time is spent per ride
  - Based on date and time factors such as day of week and time of day
  - Based on which station is the starting and / or ending station
  - Based on age of the rider at time of the ride
  - Based on whether the rider is a member or a casual rider
  
2. Analyze how much money is spent
  - Per month, quarter, year
  - Per member, based on the age of the rider at account start
  
3. Analyze how much money is spent per member
  - Based on how many rides the rider averages per month
  - Based on how many minutes the rider spends on a bike per month
  
# STEPS FOR THE PROJECT
# Task 1: Create Azure resources
- Create an Azure Synapse workspace
- Create a Dedicated SQL Pool and database within the Synapse workspace

# Task 2: Design a star schema
Based on the given set of business requirements the following star schema was designed
![image](https://user-images.githubusercontent.com/61830624/195540920-fb4a99e0-7a3b-4dd6-8769-bc2b82156b3c.png)

# Task 3: Create the data in PostgreSQL
To prepare the environment for this project, we first must create the data in PostgreSQL. This will simulate the production environment where the data is being used in the OLTP system. This can be done using the Python script `ProjectDataToPostgres.py`

We can verify that our data exists by using pgAdmin 

![image](https://user-images.githubusercontent.com/61830624/195542599-83dafffd-e1f6-4e7c-8556-901036adacc3.png)


# Task 4: EXTRACT the data from PostgreSQL
In our Azure Synapse workspace, we will use the ingest wizard to create a one-time pipeline that ingests the data from PostgreSQL into Azure Blob Storage. This will result in all four tables being represented as text files in Blob Storage, ready for loading into the data warehouse.

### 4.1 Create New linked service in Azure synapse studio
![image](https://user-images.githubusercontent.com/61830624/195543191-650cc93d-fa9e-49fb-81a8-985c3e13b189.png)

### 4.2 Create new linked service for Azure Blob Storage
![image](https://user-images.githubusercontent.com/61830624/195544235-318b4550-1f05-4708-bbda-b6b61b6f3299.png)

### 4.3 Ingest Data into Blob Storage

First, we use Copy data tool
![image](https://user-images.githubusercontent.com/61830624/195545320-553df5ed-43f7-4670-832a-9916071fd71f.png)

Source data will be our posgresql data and we select the required tables
![image](https://user-images.githubusercontent.com/61830624/195546585-6a0b2e7d-8170-4470-b1e9-9ac682ab2cb1.png)

Destination for our data is our Azure Blob Storage
![image](https://user-images.githubusercontent.com/61830624/195549537-b98c966b-656d-47a2-b590-e0a1a712899c.png)

Pipeline successfully created
![image](https://user-images.githubusercontent.com/61830624/195548143-7d6c9caa-985b-495c-a334-9fc7d962449c.png)

### 4.4 Data Successfully loaded in our Container in our Storage account
![image](https://user-images.githubusercontent.com/61830624/195575952-58d727f8-da24-4a7e-a978-2629a52f9596.png)

# Task 5: LOAD the data into external tables in the data warehouse
Once in Blob storage, the files will be shown in the data lake node in the Synapse Workspace. From here, we can use the script generating function to load the data from blob storage into external staging tables in the data warehouse we created using the Dedicated SQL Pool.

### 5.1 Create external table
![image](https://user-images.githubusercontent.com/61830624/195560797-8bfafbc2-408c-4dfa-8220-483da1321f52.png)

#### External table staging_payment 
![image](https://user-images.githubusercontent.com/61830624/195577043-c2737fd9-cdf7-4130-b881-540fc7035938.png)

#### External table staging_rider 
![image](https://user-images.githubusercontent.com/61830624/195579843-ed0fe9c3-c35e-44ed-91ca-4e2c022fe652.png)

 #### External table staging_station
 ![image](https://user-images.githubusercontent.com/61830624/195580503-00229681-5a3b-4d07-af7e-0f38e0a6a528.png)
 
 #### External table staging_trip
 ![image](https://user-images.githubusercontent.com/61830624/195581463-470a66e3-2fb0-487f-b591-9c84e083cafb.png)
 
 #### All the External Tables are available in our SQL database in our Workspace
 ![image](https://user-images.githubusercontent.com/61830624/195581830-d0b30059-3bf8-44f9-9ab4-7027df859e74.png)
 
 # Task 6: TRANSFORM the data to the star schema
We will write SQL scripts to transform the data from the staging tables to the final star schema we designed.
The scripts for the facts and dimension tables can be found in the `Transform_star_schema` folder

#### Create Station Dimension Table 
![image](https://user-images.githubusercontent.com/61830624/195591163-172b453e-629d-4580-a472-b5d4b168b7f6.png)

#### Create riders dimension table
![image](https://user-images.githubusercontent.com/61830624/195592379-c5c33367-e757-4ab8-b985-7e273e3b3e08.png)

#### We have all the dimension and fact table in our sql databse which we can now use to answer our business questions
![image](https://user-images.githubusercontent.com/61830624/195598047-54b7f1d6-29c6-4049-8f97-74ee8a09c79f.png)

  

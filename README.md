# Readme for the Rocket Elevators website at http://rocketelevators.online/

* Ruby version : ruby 2.6.6

* Rails version: Rails 5.2.6

* Important Gems: Cancancan, rails-Admin, Devise,Rolify, Pg & Multiverse, rails-Admin.

* Databases: MySQL(rocket_development) & PostgreSQL(datawarehouse_development).

* General MySQL terminal commands concerning the rocket_development database:
    "rails db:create db:migrate db:seed"   RECOMENDED TO BE DONE AT ONCE

* General ProgreSQL terminal commands concerning the datawarehouse_development database:
    DB=datawarehouse rails db:drop
    DB=datawarehouse rails db:create
    DB=datawarehouse rails db:migrate
    DB=datawarehouse rails db:seed
    
* MySQL Tables: Users, Employees, Roles, Quotes, Leads, Adress, Customers, Buildings, BuildingDetails,
    Battery, Columns & Elevarors.
* PostgreSQL Tables: FactQuotes, FactContact, FactElevator & DimCustomers

* Seeding: 21 users(with the password of "codeboxx") & employees, 25 quote forms, 10 leads(ContactUs forms),
    100 adresses, 50 customers, 50 building details,50 buildings, each buildings has 1
    battery  (Total : 50 battery), each battery has 3 columns(Total : 150 columns) & each column has 4 
    elevators (Total : 600 elevators).

* Admin of the site: All of the employees of Rocket Elevators havec the admin privileges so it is possible 
    to have access to the Back Office by connecting to their accounts. We used the email adress of nicolas.genest@codeboxx.biz with password codeboxx to test the website.

* Back Office ONLY visible to admins.

* Data transfer from MySQL to PostgreSQL is done through rake tasks.

* For all the data transfers and making the right relationships for the transfers, the ":import" rake task 
    has been used.

* SQL Queries : psql postgres -h 127.0.0.1 -d datawarehouse_development -f QuoteRequest.sql
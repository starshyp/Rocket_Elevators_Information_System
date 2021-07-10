# namespace :dwh do

#   desc 'My import task'
#   require "pg"
#   require "faker"

#   task :connection_mysql do
#     mysql = ActiveRecord::Base.establish_connection(Rails.configuration.database_configuration["datawarehouse_development"])
#     puts mysql.connection.current_database
#   end

#   task :connection_postgres  do 
    # conn = PG.connect(
    #   host: Rails.configuration.database_configuration["datawarehouse_development"]["host"],
    #   dbname: Rails.configuration.database_configuration["datawarehouse_development"]["database"],
    #   password: Rails.configuration.database_configuration["datawarehouse_development"]["password"],
    #   user: Rails.configuration.database_configuration["datawarehouse_development"]["username"]
    # )
#     puts conn
#     puts "connection postgres"

#   end

#   task clear: :environment do
    
#     conn = PG.connect(
#       host: Rails.configuration.database_configuration["datawarehouse_development"]["host"],
#       dbname: Rails.configuration.database_configuration["datawarehouse_development"]["database"],
#       password: Rails.configuration.database_configuration["datawarehouse_development"]["password"],
#       user: Rails.configuration.database_configuration["datawarehouse_development"]["username"]
#     )
#     puts "Clearing DWH data structure"
#     conn.exec("TRUNCATE fact_quotes, fact_contacts, fact_elevators, dim_customers, fact_interventions")
#     puts "Cleared DWH data structure"
#   end
  
#   desc "Import from MySQL data to Postgres"
#   task import: :environment do
#     Rake::Task["dwh:clear"].invoke()

#     conn = PG.connect(
#       host: Rails.configuration.database_configuration["datawarehouse_development"]["host"],
#       dbname: Rails.configuration.database_configuration["datawarehouse_development"]["database"],
#       password: Rails.configuration.database_configuration["datawarehouse_development"]["password"],
#       user: Rails.configuration.database_configuration["datawarehouse_development"]["username"]
#     )
#     # puts conn
#     puts "Rebuilding DWH data structure"

#     puts "    Building fact_quotes data structure"
#     conn.prepare("factquote", 'INSERT INTO fact_quotes ("QuoteId", "Creation", "CompanyName", "Email", "NbElevator") VALUES ($1, $2, $3, $4, $5)')
#     Quote.find_each do |index|

#       conn.exec_prepared("factquote", [index.id, index.created_at, index.CompanyName, index.Email, index.ElevatorAmount])
#     end
    
#     puts "    Building fact_contacts data structure"
#     conn.prepare("factcontact", 'INSERT INTO fact_contacts ("ContactId", "CreationDate", "CompanyName", "Email", "ProjectName") VALUES ($1, $2, $3, $4, $5)')
#     Lead.find_each do |index|

#       conn.exec_prepared("factcontact", [index.id, index.created_at, index.CompanyName, index.Email, index.ProjectName])
#     end

#     puts "    Building fact_elevators data structure"
#     conn.prepare("factelevators", 'INSERT INTO fact_elevators ("SerialNumber", "DateOfCommissioning", "BuildingId", "CustomerId", "BuildingCity") VALUES ($1, $2, $3, $4, $5)')
#     Elevator.find_each do |index|
      
#       buildingid = nil
#       customerid = nil
#       buildingcity = nil
#       column = Column.find(index.column_id)
#       if column.present?
#         battery = Battery.find(column.battery_id)
#         if battery.present?
#           buildingid = battery.building_id
#           building = Building.find(battery.building_id)
#           if building.present?
#             customerid = building.customer_id
#             address = Address.find(building.address_id)
#             if address.present?
#               buildingcity = address.City
#             end
#           end
#         end
#       end
#       conn.exec_prepared("factelevators", [index.SerialNumber, index.DateOfCommissioning, buildingid, customerid, buildingcity])
#     end
#     conn.prepare("dimcustomers", 'INSERT INTO dim_customers ("CreationDate", "CompanyName", "FullNameOfCompanyNameContact", "EmailOfCompanyMainContact", "NbElevators", "CustomerCity") VALUES ($1, $2, $3, $4, $5, $6)')
#     puts "    Building dim_customers data structure"

#     customers = []

#     Customer.find_each do |customerindex|
#       customercity = nil

#       address = Address.find(customerindex.address_id)
#       if address.present?
#         customercity = address.City
#       end
#       customers += [[customerindex.created_at, customerindex.CompanyName, customerindex.NameOfContact, customerindex.EmailOfTheCompany, 0, customercity]]
#     end

#     Elevator.find_each do |elevator|
#       column = Column.find(elevator.column_id)
#       if column.present?
#         battery = Battery.find(column.battery_id)
#         if battery.present?
#           building = Building.find(battery.building_id)
#           if building.present?
#             customerid = building.customer_id
#             for i in 0...customers.length() do
#               if i == customerid
#                 customers[i][4] += 1
#               end
#             end
#           end
#         end
#       end
#     end
#     for i in 0...customers.length() do
#       conn.exec_prepared("dimcustomers", customers[i])
#     end


    # puts "    Building fact_interventions data structure"
    # # conn.prepare("factintervention", 'INSERT INTO fact_interventions ("EmployeeID", "BuildingID", "BatteryID", "ColumnID", "ElevatorID", "Start_date", "End_date", "Result", "Report", "Status" ) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10)')
    # conn.prepare("factintervention", 'INSERT INTO fact_interventions ("EmployeeID", "BuildingID", "Start_date", "End_date", "Result", "Status" ) VALUES ($1, $2, $3, $4, $5, $6)')

#       # task import: :environment do

#         result = ["Success", "Failure", "Incomplete"]
#         status = ["Pending", "In Progress", "Interrupted", "Resumed", "Complete"]

#         50.times do |index|
#           fact_intervention = FactIntervention.create!(
#               EmployeeID: rand(50),
#               BuildingID: rand(50),
#               BatteryID: rand(50),
#               ColumnID: rand(50),
#               ElevatorID: rand(50),
#               Start_date: Faker::Time.between(from: DateTime.now - 1, to: DateTime.now),
#               End_date: Faker::Time.between(from: DateTime.now - 1, to: DateTime.now),
#               Result: result.sample,
#               Report: Faker::Lorem.sentence(word_count: 3),
#               Status: status.sample
#           )
#         end
#         # conn.exec_prepared("factintervention", [index.EmployeeID, index.BuildingID, index.BatteryID, index.ColumnID, index.ElevatorID, index.Start_date, index.End_date,index.Result, index.Report, index.Status])
#         conn.exec_prepared("factintervention", [index.EmployeeID, index.BuildingID, index.Start_date, index.End_date, index.Result, index.Status])
#       # end

#     # end
#   end
# end

con = PG::Connection.open(host: Rails.configuration.database_configuration["datawarehouse_development"]["host"],
dbname: Rails.configuration.database_configuration["datawarehouse_development"]["database"],
password: Rails.configuration.database_configuration["datawarehouse_development"]["password"],
user: Rails.configuration.database_configuration["datawarehouse_development"]["username"]
)

random_status = [“Pending”, “InProgress”, “Interrupted”, “Resumed”, “Complete”]
random_result = [“Success”, “Failure”, “Incomplete”]
random_id = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21]
namespace :api do
 desc “FactIntervention table”
 task factintervention: :environment do
  con.exec(‘DROP TABLE IF EXISTS FactIntervention’)
  con.exec(‘CREATE TABLE FactIntervention(
   id INT,
   EmployeeID INT,
   BuildingID INT,
   BatteryID INT,
   ColumnID INT,
   ElevatorID INT,
   Start_date TIMESTAMP,
   End_date TIMESTAMP,
   Result VARCHAR,
   Report VARCHAR,
   Status VARCHAR) ;’)
 end
 task fiseed: :environment do
  con.exec(“TRUNCATE TABLE FactIntervention RESTART IDENTITY;“)
  Employee.all.each do |e|
  # Building.all.each do |b|
  EmployeeID = random_id.delete(random_id.sample)
  BuildingID = Faker::Number.number(digits: 2)
  BatteryID = Faker::Number.number(digits: 2)
  ColumnID = Faker::Number.number(digits: 2)
  ElevatorID = Faker::Number.number(digits: 2)
  # Start_date = Faker::Time.between(from: ‘2021-01-01 00:00:00’, to: ‘2021-03-01 23:59:59’)
  # End_date = Faker::Time.between(from: ‘2021-03-01 00:00:00’, to: ‘2021-07-01 23:59:59’)
  Result = random_status.sample
  # Report = random_result.sample
  Status = random_status.sample
  con.exec(“INSERT INTO FactIntervention (id, EmployeeID, BuildingID, BatteryID, ColumnID, ElevatorID, Start_date, End_date, Result, Status, Report) VALUES (#{fakeid}, #{e.user_id}, #{fakeBuildingId}, #{fakeBatteryId}, #{fakeColumnId}, #{fakeElevatorId}, ‘#{fakeStartDate}‘, ‘#{fakeEndDate}‘, ‘#{status}‘, ‘#{result}‘, ‘#{fakeReport}’);“)
  end
 end
 # task fiseed: :environment do
 #  con.exec(“TRUNCATE TABLE FactIntervention RESTART IDENTITY;“)
 #  Building.all.each do |bld|
 #   buildingID = bld.building_detail.building_id
 #   fakeStartDate = Faker::Time.between(from: ‘2021-01-01 00:00:00’, to: ‘2021-07-01 23:59:59’)
 #   status = random_status.sample
 #   result = random_result.sample
 #   bld.batteries.all.each do |bat|
 #    batteryID = bat.id
 #    bat.employee do |emp|
 #     employeeID = emp.id
 #    end
 #   end
 #   con.exec(“INSERT INTO FactIntervention (EmployeeID, BuildingID, BatteryID, Status, Result) VALUES (#{employeeID}, #{buildingID}, ‘#{batteryID}‘, ‘#{status}‘, ‘#{result}’);“)
 #  end
end
namespace :dwh do

  desc 'My import task'
  require "pg"
  require "faker"

  task :connection_mysql do
    mysql = ActiveRecord::Base.establish_connection(Rails.configuration.database_configuration["datawarehouse_development"])
    puts mysql.connection.current_database
  end

  task :connection_postgres  do 
    conn = PG.connect(
      host: Rails.configuration.database_configuration["datawarehouse_development"]["host"],
      dbname: Rails.configuration.database_configuration["datawarehouse_development"]["database"],
      password: Rails.configuration.database_configuration["datawarehouse_development"]["password"],
      user: Rails.configuration.database_configuration["datawarehouse_development"]["username"]
    )
    puts conn
    puts "connection postgres"

  end

  task clear: :environment do
    
    conn = PG.connect(
      host: Rails.configuration.database_configuration["datawarehouse_development"]["host"],
      dbname: Rails.configuration.database_configuration["datawarehouse_development"]["database"],
      password: Rails.configuration.database_configuration["datawarehouse_development"]["password"],
      user: Rails.configuration.database_configuration["datawarehouse_development"]["username"]
    )
    puts "Clearing DWH data structure"
    conn.exec("TRUNCATE fact_quotes, fact_contacts, fact_elevators, dim_customers, fact_interventions")
    puts "Cleared DWH data structure"
  end
  
  desc "Import from MySQL data to Postgres"
  task import: :environment do
    Rake::Task["dwh:clear"].invoke()
    
    conn = PG.connect(
      host: Rails.configuration.database_configuration["datawarehouse_development"]["host"],
      dbname: Rails.configuration.database_configuration["datawarehouse_development"]["database"],
      password: Rails.configuration.database_configuration["datawarehouse_development"]["password"],
      user: Rails.configuration.database_configuration["datawarehouse_development"]["username"]
    )
    puts "Rebuilding DWH data structure"

    puts "    Building fact_quotes data structure"
    conn.prepare("factquote", 'INSERT INTO fact_quotes ("QuoteId", "Creation", "CompanyName", "Email", "NbElevator") VALUES ($1, $2, $3, $4, $5)')
    Quote.find_each do |index|

      conn.exec_prepared("factquote", [index.id, index.created_at, index.CompanyName, index.Email, index.ElevatorAmount])
    end
    
    puts "    Building fact_contacts data structure"
    conn.prepare("factcontact", 'INSERT INTO fact_contacts ("ContactId", "CreationDate", "CompanyName", "Email", "ProjectName") VALUES ($1, $2, $3, $4, $5)')
    Lead.find_each do |index|

      conn.exec_prepared("factcontact", [index.id, index.created_at, index.CompanyName, index.Email, index.ProjectName])
    end

    puts "    Building fact_elevators data structure"
    conn.prepare("factelevators", 'INSERT INTO fact_elevators ("SerialNumber", "DateOfCommissioning", "BuildingId", "CustomerId", "BuildingCity") VALUES ($1, $2, $3, $4, $5)')
    Elevator.find_each do |index|
      
      buildingid = nil
      customerid = nil
      buildingcity = nil
      column = Column.find(index.column_id)
      if column.present?
        battery = Battery.find(column.battery_id)
        if battery.present?
          buildingid = battery.building_id
          building = Building.find(battery.building_id)
          if building.present?
            customerid = building.customer_id
            address = Address.find(building.address_id)
            if address.present?
              buildingcity = address.City
            end
          end
        end
      end
      conn.exec_prepared("factelevators", [index.SerialNumber, index.DateOfCommissioning, buildingid, customerid, buildingcity])
    end
    conn.prepare("dimcustomers", 'INSERT INTO dim_customers ("CreationDate", "CompanyName", "FullNameOfCompanyNameContact", "EmailOfCompanyMainContact", "NbElevators", "CustomerCity") VALUES ($1, $2, $3, $4, $5, $6)')
    puts "    Building dim_customers data structure"

    customers = []

    Customer.find_each do |customerindex|
      customercity = nil

      address = Address.find(customerindex.address_id)
      if address.present?
        customercity = address.City
      end
      customers += [[customerindex.created_at, customerindex.CompanyName, customerindex.NameOfContact, customerindex.EmailOfTheCompany, 0, customercity]]
    end

    Elevator.find_each do |elevator|
      column = Column.find(elevator.column_id)
      if column.present?
        battery = Battery.find(column.battery_id)
        if battery.present?
          building = Building.find(battery.building_id)
          if building.present?
            customerid = building.customer_id
            for i in 0...customers.length() do
              if i == customerid
                customers[i][4] += 1
              end
            end
          end
        end
      end
    end
    for i in 0...customers.length() do
      conn.exec_prepared("dimcustomers", customers[i])
    end

    # task intervention: :environment do
    #   require "faker"
    #   result = ["Success", "Failure", "Incomplete"]
    #   status = ["Pending", "In Progress", "Interrupted", "Resumed", "Complete"]
    #   50.times do |i|
    #     intervention = FactIntervention.create!(
    #       Employee_ID: rand(50),
    #       Building_ID: rand(50),
    #       Battery_ID: rand(100),
    #       Column_ID: rand(300),
    #       Elevator_ID: rand(1000),
    #       Start_date: Faker::Time.between(from: DateTime.now - 1, to: DateTime.now),
    #       End_date: Faker::Time.between(from: DateTime.now - 1, to: DateTime.now),
    #       Result: result.sample,
    #       Report: Faker::Lorem.sentence(word_count: 3),
    #       Status: status.sample,
    #     )
    #   end
    # end

    puts "    Building fact_interventions data structure"
    conn.prepare("factintervention", 'INSERT INTO fact_interventions ("EmployeeID", "BuildingID", "Start_date", "End_date", "Result", "Status" ) VALUES ($1, $2, $3, $4, $5, $6)')
    # # FactIntervention.find_each do |index|

    # conn.exec_prepared("factintervention", [EmployeeID, BuildingID, Start_date, End_date, Result, Status])

     
    
      task import: :environment do

        result = ["Success", "Failure", "Incomplete"]
        status = ["Pending", "In Progress", "Interrupted", "Resumed", "Complete"]

        50.times do |index|
          fact_intervention = FactIntervention.create!(
              EmployeeID: rand(50),
              BuildingID: rand(50),
              BatteryID: rand(100),
              ColumnID: rand(300),
              ElevatorID: rand(1000),
              Start_date: Faker::Time.between(from: DateTime.now - 1, to: DateTime.now),
              End_date: Faker::Time.between(from: DateTime.now - 1, to: DateTime.now),
              Result: result.sample,
              Report: Faker::Lorem.sentence(word_count: 3),
              Status: status.sample,
          )
        end
        # result = ["Success", "Failure", "Incomplete"]
        # status = ["Pending", "In Progress", "Interrupted", "Resumed", "Complete"]
        #   Elevator.all.each do |index|
        #     FactIntervention.create!({
        #     for e in Employee.all do
        #       EmployeeID = e.id,
        #         for b in Building.all do
        #           BuildingID = b.id
        #           BatteryID = nil,
        #             ColumnID = nil,
        #             ElevatorID = index.id,
        #             column = Column.find(index.column_id)
        #           if column.present?
        #             ColumnID = column.id
        #             battery = Battery.find(column.battery_id)
        #             if battery.present?
        #               BatteryID = battery.building_id
        #             end
        #           end
        #         end
        #       Start_date: Faker::Time.between(from: DateTime.now - 1, to: DateTime.now)
        #       End_date: Faker::Time.between(from: DateTime.now - 1, to: DateTime.now)
        #       Result: result.sample
        #       Report: Faker::Lorem.sentence(word_count: 3)
        #       Status: status.sample
        #     end 
        #   })
        # end
        # task intervention: :environment do
        #   require "faker"
        #   result = ["Success", "Failure", "Incomplete"]
        #   status = ["Pending", "In Progress", "Interrupted", "Resumed", "Complete"]
        #   50.times do |i|
        #     intervention = FactIntervention.create!(
        #       Employee_ID: rand(50),
        #       Building_ID: rand(50),
        #       Battery_ID: rand(100),
        #       Column_ID: rand(300),
        #       Elevator_ID: rand(1000),
        #       Start_date: Faker::Time.between(from: DateTime.now - 1, to: DateTime.now),
        #       End_date: Faker::Time.between(from: DateTime.now - 1, to: DateTime.now),
        #       Result: result.sample,
        #       Report: Faker::Lorem.sentence(word_count: 3),
        #       Status: status.sample,
        #     )
        #   end
        # end
        
        conn.exec_prepared("factintervention", [index.EmployeeID, index.BuildingID, index.Start_date, index.End_date,index.Result, index.Status])
      end
    end
  end
# end

  
        #   FactIntervention.delete_all
        #   Employee.all.each do |e|
        #     FactIntervention.create!(
        #     EmployeeID: e.id
        #     :FirstName => e.FirstName,
        #     :LastName => e.LastName,
        #     :Email => e.email,
        #     :created_at => e.number_of_elevators
        #     :updated_at => e.number_of_elevators
        #     )
        #   end
        #   end

        # FactIntervention.delete_all
        # Building.all.each do |b|
        #   FactIntervention.create!(
        #   BuildingID: b.id
        #   :FullNameOfTheBuildingAdministrator => b.FullNameOfTheBuildingAdministrator,
        #   :EmailOfTheAdministratorOfTheBuilding => b.EmailOfTheAdministratorOfTheBuilding,
        #   :PhoneNumberOfTheBuildingAdministrator => b.PhoneNumberOfTheBuildingAdministrator,
        #   :FullNameOfCompanyNameContact => b.FullNameOfCompanyNameContact
        #   :TechContactEmail => b.TechContactEmail
        #   :TechContactPhone => b.TechContactPhone
        #   :created_at => b.created_at
        #   :updated_at => b.updated_at
        #   )
        #   end
        #   end

        #  conn.exec_prepared("fact_intervention", [i.EmployeeID, i.BuildingID, i.Start_date, i.End_date, i.Result, i.Status])
        #   # end
        # end
        # conn.fact_intervention.push()

        #               how to find a random id of a model
        #     EmployeeID: Employee.id,
        #     BuildingID: Building.id,
        #     Start_date: Faker::Date.backward(days: 14),
        #     End_date: Faker::Date.backward(days: 14),
        #     Result: result.sample,
        #     Status: status.sample

# namespace :dwh do
#   desc 'My import task'
#   require "pg"
#   task :connection_mysql do
#     mysql = ActiveRecord::Base.establish_connection(Rails.configuration.database_configuration["development"])
#     puts mysql.connection.current_database
#   end
#   task :connection_postgres  do 
#     conn = PG.connect(
#       host: Rails.configuration.database_configuration["datawarehouse_development"]["host"],
#       dbname: Rails.configuration.database_configuration["datawarehouse_development"]["database"],
#       password: Rails.configuration.database_configuration["datawarehouse_development"]["password"],
#       user: Rails.configuration.database_configuration["datawarehouse_development"]["username"]
#     )
#     puts conn
#     puts "connection postgres"
#   end
#   task clear: :environment do
#     conn = PG.connect(
#         host: Rails.configuration.database_configuration["datawarehouse_development"]["host"],
#         dbname: Rails.configuration.database_configuration["datawarehouse_development"]["database"],
#         password: Rails.configuration.database_configuration["datawarehouse_development"]["password"],
#         user: Rails.configuration.database_configuration["datawarehouse_development"]["username"]
#       )    
#     puts "Clearing DWH data structure"
#     conn.exec("TRUNCATE fact_quotes, fact_contacts, fact_elevators, dim_customers")
#     puts "Cleared DWH data structure"
#   end
#   desc "Import from MySQL data to Postgres"
#   task import: :environment do
#     Rake::Task["dwh:clear"].invoke()
#     conn = PG.connect(host: '', user: '', dbname: '', password: '')
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
#   end
  
# end
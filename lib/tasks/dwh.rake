namespace :dwh do

  desc 'My import task'
  require "pg"

  task :connection_mysql do
    mysql = ActiveRecord::Base.establish_connection(Rails.configuration.database_configuration["development"])
    puts mysql.connection.current_database
  end

  task :connection_postgres  do 
    conn = PG.connect( dbname: 'datawarehouse_development', password: 'postgres')
    puts conn
  end
  
  task import: :environment do
    conn = PG.connect( dbname: 'datawarehouse_development', password: 'postgres')
    Employee.find_each do |lu|
      puts lu.user_id
      conn.exec("INSERT INTO fact_quotes (\"QuoteId\") VALUES (#{lu.user_id})")
    end
    # Employee.find_each do |lu|
    #   puts "#{lu.id} - #{lu.FirstName}"
    # end
  end

  task factquotes: :environment do
    conn = PG.connect( dbname: 'datawarehouse_development', password: 'postgres')
    # Quote.find_each do |q|
    #  # puts q.user_id
    #   conn.exec("INSERT INTO fact_quotes (\"QuoteId\") VALUES (#{q.id})")
    #   conn.exec("INSERT INTO fact_quotes (\"Creation\") VALUES (#{q.created_at})")
    #   conn.exec("INSERT INTO fact_quotes (\"CompanyName\") VALUES (#{q.CompanyName})")
    #   conn.exec("INSERT INTO fact_quotes (\"Email\") VALUES (#{q.Email})")
    #   conn.exec("INSERT INTO fact_quotes (\"NbElevator\") VALUES (#{q.ElevatorAmount})")
    conn.prepare("quote", 'INSERT INTO fact_quotes ("QuoteId", "Creation", "CompanyName", "Email", "NbElevator") VALUES ($1, $2, $3, $4, $5)')
    Quote.find_each do |index|
      puts index.id
      conn.exec_prepared("quote", [index.id, index.created_at, index.CompanyName, index.Email, index.ElevatorAmount])
    end
  end
end

    

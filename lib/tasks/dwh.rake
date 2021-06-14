namespace :dwh do

  desc 'My import task'
  require "pg"

  task :connection_mysql do
    mysql = ActiveRecord::Base.establish_connection(Rails.configuration.database_configuration["development"])
    puts mysql.connection.current_database
  end

  task :connection_postgres  do 
    conn = PG.connect( dbname: 'datawarehouse_development', password: 'postgres'
    )
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

  task my_task2: :environment do
  end
end

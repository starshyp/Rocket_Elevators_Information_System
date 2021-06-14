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
    conn = PG.connect( dbname: 'datawarehouse_development', password: 'postgres'
    )
    conn.exec( 'INSERT INTO fact_quotes (QuoteId, column2, column3, ...)
    SELECT column1, column2, column3, ...
    FROM table1' ) do |result|
      puts "     PID | User             | Query"
      result.each do |row|
        puts " %7d | %-16s | %s " %
          row.values_at('pid', 'usename', 'query')
      end
    end
    # Employee.find_each do |lu|
    #   puts "#{lu.id} - #{lu.FirstName}"
    # end
  end

  task my_task2: :environment do
  end
end

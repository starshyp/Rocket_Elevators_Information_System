namespace :dwh do

  desc 'My import task'


  task :connection_mysql do
    mysql = ActiveRecord::Base.establish_connection(Rails.configuration.database_configuration["development"])
    puts mysql.connection.current_database
  end

  task :connection_postgres  do 
    postgre=ActiveRecord::Base.establish_connection(
      host: "localhost",
      username: "postgres",
      password: "postgres",
      adapter: "postgresql",
      encoding: "unicode",
      database: "datawarehouse_development")
      puts postgre.connection.current_database
    end
  end

  task :import do
    

    Quote.all.each do |q|
      q.
      #res.user.name+","+res.concert.name+","+res.concert.date # etc.
   end
  end


  desc "TODO"
  task my_task2: :environment do
  end

end

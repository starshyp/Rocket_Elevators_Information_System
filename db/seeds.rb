# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


Employee.destroy_all
User.destroy_all


user = User.create!(
email: "nicolas.genest@codeboxx.biz",
password:"codeboxx",
password_confirmation:"codeboxx")
user.add_role :admin

employees=Employee.create!(
Title: "CEO",
FirstName: "Nicolas",
LastName: "Genest",
Email: "nicolas.genest@codeboxx.biz",
user: user)

user = User.create!(
email: "nadya.fortier@codeboxx.biz",
password:"codeboxx",
password_confirmation:"codeboxx")
user.add_role :admin

employees=Employee.create!(
Title: "Director",
FirstName: "Nadya",
LastName: "Fortier",
Email: "nadya.fortier@codeboxx.biz",
user: user)

user = User.create!(
email: "martin.chantal@codeboxx.biz",
password:"codeboxx",
password_confirmation:"codeboxx")
user.add_role :admin

employees=Employee.create!(
Title: "Assistant Director",
FirstName: "Martin",
LastName: "Chantal",
Email: "martin.chantal@codeboxx.biz",
user: user)
   
    
user = User.create!(
email: "mathieu.houde@codeboxx.biz",
password:"codeboxx",
password_confirmation:"codeboxx")
user.add_role :admin

employees=Employee.create!(
Title: "Captain",
FirstName: "Mathieu",
LastName: "Houde",
Email: "mathieu.houde@codeboxx.biz",
user: user)

user = User.create!(
  email:"patrick.thibault@codeboxx.biz" ,
  password:"codeboxx",
  password_confirmation:"codeboxx")
  user.add_role :admin  

employees=Employee.create!(
Title: "Captain",
FirstName: "Patrick",
LastName: "Thibault",
Email: "patrick.thibault@codeboxx.biz",
user: user )

user = User.create!(
email:"david.boutin@codeboxx.biz",
password:"codeboxx",
password_confirmation:"codeboxx")
user.add_role :admin

employees=Employee.create!(
Title: "Engineer",
FirstName: "David",
LastName: "Boutin",
Email: "david.boutin@codeboxx.biz",
user: user )

user = User.create!(
email:"mathieu.lortie@codeboxx.biz",
password:"codeboxx",
password_confirmation:"codeboxx")
user.add_role :admin

employees=Employee.create!(
Title: "Engineer",
FirstName: "Mathieu",
LastName: "Lortie",
Email: "mathieu.lortie@codeboxx.biz",
user: user)

user = User.create!(
email:"thomas.carrier@codeboxx.biz",
password:"codeboxx",
password_confirmation:"codeboxx")
user.add_role :admin

employees=Employee.create!(
Title: "Engineer",
FirstName: "Thomas",
LastName: "Carrier",
Email: "thomas.carrier@codeboxx.biz",
user: user)

user = User.create!(
email:"serge.savoie@codeboxx.biz",
password:"codeboxx",
password_confirmation:"codeboxx")
user.add_role :admin

employees=Employee.create!(
Title: "Engineer",
FirstName: "Serge",
LastName: "Savoie",
Email: "serge.savoie@codeboxx.biz",
user: user)

user = User.create!(
email:"francis.patry-jessop@codeboxx.biz",
password:"codeboxx",
password_confirmation:"codeboxx")
user.add_role :admin

employees=Employee.create!(
Title: "Engineer",
FirstName: "Francis",
LastName: "Patry-Jessop",
Email: "francis.patry-jessop@codeboxx.biz",
user: user)

user = User.create!(
email:"mathieu.lefrancois@codeboxx.biz",
password:"codeboxx",
password_confirmation:"codeboxx")
user.add_role :admin

employees=Employee.create!(
Title: "Engineer",
FirstName: "Mathieu",
LastName: "Lefrancois",
Email: "mathieu.lefrancois@codeboxx.biz",
user: user)

user = User.create!(
email:"david.larochelle@codeboxx.biz",
password:"codeboxx",
password_confirmation:"codeboxx")
user.add_role :admin

employees=Employee.create!(
Title: "Engineer",
FirstName: "David",
LastName: "Larochelle",
Email: "david.larochelle@codeboxx.biz",
user: user)

user = User.create!(
email:"nicolas.pineault@codeboxx.biz",
password:"codeboxx",
password_confirmation:"codeboxx")
user.add_role :admin

employees=Employee.create!(
Title: "Engineer",
FirstName: "Nicolas",
LastName: "Pineault",
Email: "nicolas.pineault@codeboxx.biz",
user: user)

user = User.create!(
email:"david.amyot@codeboxx.biz",
password:"codeboxx",
password_confirmation:"codeboxx")
user.add_role :admin

employees=Employee.create!(
Title: "Engineer",
FirstName: "David",
LastName: "Amyot",
Email: "david.amyot@codeboxx.biz",
user: user)

user = User.create!(
email:"remi.gagnon@codeboxx.biz",
password:"codeboxx",
password_confirmation:"codeboxx")
user.add_role :admin

employees=Employee.create!(
Title: "Engineer",
FirstName: "Remi",
LastName: "Gagnon",
Email: "remi.gagnon@codeboxx.biz",
user: user)

user = User.create!(
email:"timothy.wever@codeboxx.biz",
password:"codeboxx",
password_confirmation:"codeboxx")
user.add_role :admin

employees=Employee.create!(
Title: "Developer",
FirstName: "Timothy",
LastName: "Wever",
Email: "timothy.wever@codeboxx.biz",
user: user)

user = User.create!(
email:"kiril.kleinerman@codeboxx.biz",
password:"codeboxx",
password_confirmation:"codeboxx")
user.add_role :admin

employees=Employee.create!(
Title: "Developer",
FirstName: "Kiril",
LastName: "Kleinerman",
Email: "kiril.kleinerman@codeboxx.biz",
user: user)

user = User.create!(
email:"emmanuela.derilus@codeboxx.biz",
password:"codeboxx",
password_confirmation:"codeboxx")
user.add_role :admin

employees=Employee.create!(
Title: "Developer",
FirstName: "Emmanuela",
LastName: "Derilus",
Email: "emmanuela.derilus@codeboxx.biz",
user: user)

user = User.create!(
email: "abdul.akeeb@codebozz.biz",
password:"codeboxx",
password_confirmation:"codeboxx")
user.add_role :admin

employees=Employee.create!(
Title: "Developer",
FirstName: "Abdul",
LastName: "Akeeb",
Email: "abdul.akeeb@codebozz.biz",
user: user)

user = User.create!(
email:"krista.sheely@codeboxx.biz",
password:"codeboxx",
password_confirmation:"codeboxx")
user.add_role :admin

employees=Employee.create!(
Title: "Developer",
FirstName: "Krista",
LastName: "Sheely",
Email: "krista.sheely@codeboxx.biz",
user: user)

user = User.create!(
email:"jonathan.murray@codeboxx.biz",
password:"codeboxx",
password_confirmation:"codeboxx")
user.add_role :admin

employees=Employee.create!(
Title: "Developer",
FirstName: "Jonathan",
LastName: "Murray",
Email: "jonathan.murray@codeboxx.biz",
user: user)

for _ in 1..50 # Loop User*********************
  customers = User.create!(
    email: Faker::Internet.email,
    password:"codeboxx",
    password_confirmation:"codeboxx")
  end

# Address Faker Rayan
require 'faker'
Faker::Config.locale = 'en'

departements = ["Residential", "Commercial", "Corporate", "Hybrid"]

for _ in 1..10  # Loop Lead ******************************
  lead = Lead.create!(
    FullName: Faker::Name.name,
    CompanyName: Faker::Company.name,
    Email: Faker::Internet.email,
    Phone: Faker::PhoneNumber.cell_phone,
    ProjectName: Faker::Commerce.product_name,
    ProjectDescription: Faker::Lorem.sentence(word_count: 3),
    Departement: departements.sample,
    Message: Faker::Lorem.sentence(word_count: 3),
    AttachedFile: Faker::File.extension,
    DateOfRequest: Faker::Date.between(from: '2021-06-15', to: '2021-12-30')
  )
  puts lead
end

types = ["Billing", "Shipping", "Home", "Business"];
entity = ["Customer", "Building"];

for _ in 1..100  # Temp Loop Adress***************************
  fakedAddress = Faker::Address;
  address = Address.create!(
    TypeOfAddress: types.sample,
    Status: fakedAddress.state_abbr,
    Entity: entity.sample,
    NumberAndStreet: fakedAddress.street_address,
    Apt: fakedAddress.street_address,
    City: fakedAddress.city,
    PostalCode: fakedAddress.postcode,
    Country: fakedAddress.country,
    Notes: Faker::Lorem.sentence(word_count: 3)
  )
  puts fakedAddress
  puts address
end

# Faker::Number.unique.between(from: 1, to: 21)
# if value.between?(lower, higher) (10..20).member?(14)
nbUser = User.count
# nbAddress = Address.count

for _ in 1..50 # Loop Customer*********************
  customers = Customer.create!(
    user: User.find(rand(User.count)+1),
    address: address,
    CompanyName: Faker::Company.name,
    NameOfContact: Faker::Name.name,
    CompanyContactPhone: Faker::PhoneNumber.cell_phone,
    EmailOfTheCompany: Faker::Internet.email,
    CompanyDescription: Faker::Lorem.sentence(word_count: 3),
    NameOfServiceTechAuthority: Faker::Name.name,
    TechAuhtorityPhone: Faker::PhoneNumber.cell_phone,
    TechManagerServiceEmail: Faker::Internet.email
  )
  puts customers
end

# nbCostumer = Customer.count
# nbBuilding = Building.count

for _ in 1..50   # Loop Building*******************
  building = Building.create!(
    customer: Customer.find(rand(Customer.count)+1),
    FullNameOfTheBuildingAdministrator: Faker::Name.name,
    EmailOfTheAdministratorOfTheBuilding: Faker::Internet.email,
    PhoneNumberOfTheBuildingAdministrator: Faker::PhoneNumber.cell_phone,
    FullNameOfTheTechContactForTheBuilding: Faker::Name.name,
    TechContactEmail: Faker::Internet.email,
    TechContactPhone: Faker::PhoneNumber.cell_phone
  )
  puts building

  buildingDetail = BuildingDetail.create!( #BuildingDetail in Loop Building ******************
    building: building,
    InformationKey: Faker::Drone.name,
    Value: Faker::Drone.weight
  )
  puts buildingDetail

  # nbEmployee = Employee.count

  for _ in 1..1   # Loop Battery in Building *************************
  batteries = Battery.create!(
    building: building,
    BType: departements.sample,
    employee_id: employees.id,
    DateOfCommissioning: Faker::Date.between(from: '2021-06-15', to: '2021-12-30'),
    DateOfLastInspection: Faker::Date.between(from: '2021-06-15', to: '2021-12-30'),
    CertificateOfOperations: Faker::FunnyName.name,
    Info:Faker::Lorem.sentence(word_count: 3),
    Notes: Faker::Lorem.sentence(word_count: 3)
  )
  puts batteries

  # nbBattery = Battery.count

    for _ in 1..3  # Loop Column in Battery *********************
      column = Column.create!(
        battery_id: batteries.id,
        ColumnType: departements.sample,
        NbOfFloorsServed: 1,
        Status: "on",
        Info: Faker::Lorem.sentence(word_count: 3),
        Notes: Faker::Lorem.sentence(word_count: 3)
      )
      puts column

      # nbColumn = Column.count

      for _ in 1..4  #Loop Elevator in Column **********************
        elevator = Elevator.create!(
          column_id: column.id,
          SerialNumber: Faker::Vehicle.vin,
          Model: Faker::Movies::StarWars.droid,
          ElevatorType: departements.sample,
          Status: "on",
          DateOfCommissioning: Faker::Date.between(from: '2021-06-15', to: '2021-12-30'),
          DateOfLastInspection: Faker::Date.between(from: '2021-06-15', to: '2021-12-30'),
          CertificateOfInspection: Faker::FunnyName.name ,
          Info: Faker::Lorem.sentence(word_count: 3),
          Notes: Faker::Lorem.sentence(word_count: 3)
        )
        puts elevator
      end
    end
  end
end
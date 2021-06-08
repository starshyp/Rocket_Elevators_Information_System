# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


Employee.destroy_all

employees=Employee.create([{
  Title: "CEO",
  FirstName: "Patrick",
  LastName: "Genest",
  Email: "Patrick.genest@codeboxx.biz"
},{
    Title: "Director",
    FirstName: "Nadya",
    LastName: "Fortier",
    Email: "nadya.fortier@codeboxx.biz"
  },{
    Title: "Assistant Director",
    FirstName: "Martin",
    LastName: "Chantal",
    Email: "martin.chantal@codeboxx.biz"
  },{
    Title: "Captain",
    FirstName: "Mathieu",
    LastName: "Houde",
    Email: "mathieu.houde@codeboxx.biz"
  },{
    Title: "Captain",
    FirstName: "Patrick",
    LastName: "Thibault",
    Email: "patrick.thibault@codeboxx.biz"
  },{
    Title: "Engineer",
    FirstName: "David",
    LastName: "Boutin",
    Email: "david.boutin@codeboxx.biz"
  },{
    Title: "Engineer",
    FirstName: "Mathieu",
    LastName: "Lortie",
    Email: "mathieu.lortie@codeboxx.biz"
  },{
    Title: "Engineer",
    FirstName: "Thomas",
    LastName: "Carrier",
    Email: "thomas.carrier@codeboxx.biz"
  },{
    Title: "Engineer",
    FirstName: "Serge",
    LastName: "Savoie",
    Email: "serge.savoie@codeboxx.biz"
  },{
    Title: "Engineer",
    FirstName: "Francis",
    LastName: "Patry-Jessop",
    Email: "francis.patry-jessop@codeboxx.biz"
  },{
    Title: "Engineer",
    FirstName: "Mathieu",
    LastName: "Lefrancois",
    Email: "mathieu.lefrancois@codeboxx.biz"
  },{
    Title: "Engineer",
    FirstName: "David",
    LastName: "Larochelle",
    Email: "david.larochelle@codeboxx.biz"
  },{
    Title: "Engineer",
    FirstName: "Nicolas",
    LastName: "Pineault",
    Email: "nicolas.pineault@codeboxx.biz"
  },{
    Title: "Engineer",
    FirstName: "David",
    LastName: "Amyot",
    Email: "david.amyot@codeboxx.biz"
  },{
    Title: "Engineer",
    FirstName: "Remi",
    LastName: "Gagnon",
    Email: "remi.gagnon@codeboxx.biz"
  },{
    Title: "Developer",
    FirstName: "Timothy",
    LastName: "Wever",
    Email: "timothy.wever@codeboxx.biz"
  },{
    Title: "Developer",
    FirstName: "Kiril",
    LastName: "Kleinerman",
    Email: "kiril.kleinerman@codeboxx.biz"
  },{
    Title: "Developer",
    FirstName: "Emmanuela",
    LastName: "Derilus",
    Email: "emmanuela.derilus@codeboxx.biz"
  },{
    Title: "Developer",
    FirstName: "Abdul",
    LastName: "Akeeb",
    Email: "abdul.akeeb@codebozz.biz"
  },{
    Title: "Developer",
    FirstName: "Krista",
    LastName: "Sheely",
    Email: "krista.sheely@codeboxx.biz"
  },{
    Title: "Developer",
    FirstName: "Jonathan",
    LastName: "Murray",
    Email: "jonathan.murray@codeboxx.biz"
  }
])

 p "Created #{employees.count} employees"
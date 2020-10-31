# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

roles = [{role_code: 'branch_manager', role_name: 'Branch Manager'},
         {role_code: 'customer', role_name: 'Customer'} 
        ]
puts "=========Roles creating============"
Role.create!(roles)
puts "=========Roles created============"
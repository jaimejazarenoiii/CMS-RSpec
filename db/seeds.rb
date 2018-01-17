# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = User.new(fname: "admin", lname: "admin", mobile: "1232321", email: "admin@admin.com", password: "admin123", birthdate: Time.zone.today)
user.save(validate: false)
Category.create(name: "T-shirt")
Category.create(name: "Bags")
Category.create(name: "Hats")

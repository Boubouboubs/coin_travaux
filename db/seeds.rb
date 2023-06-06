# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# Particuliers
camille = User.create(email: "camille.dion@gmail.com", password: "123456", first_name: "Camille", last_name: "Dion", phone_number: "0611223344")
david = User.create!(email: "serrano.david.liaca@gmail.com", password: "123456", first_name: "David", last_name: "Serrano", phone_number: "0611223366")
amal = User.create!(email: "amal.rabbani@gmail.com", password: "123456", first_name: "Amal", last_name: "Rabbani", phone_number: "0611223377")
boubou = User.create!(email: "boubouboubs@gmail.com", password: "123456", first_name: "Stéphanie", last_name: "Boubou", phone_number: "0611223388")
celine = User.create!(email: "celine.chader@gmail.com", password: "123456", first_name: "Céline", last_name: "Chader", phone_number: "0611223399")

camille.photo.attach(io: File.open('app/assets/images/camille.jpg'), filename: "#{camille.first_name}.jpg")
celine.photo.attach(io: File.open('app/assets/images/celine.jpg'), filename: "#{celine.first_name}.jpg")
boubou.photo.attach(io: File.open('app/assets/images/boubou.jpg'), filename: "#{boubou.first_name}.jpg")
amal.photo.attach(io: File.open('app/assets/images/armelle.jpg'), filename: "#{amal.first_name}.jpg")
david.photo.attach(io: File.open('app/assets/images/david.jpg'), filename: "#{david.first_name}.jpg")

# Entrepreneurs

# Entreprises
Company.create(user:)

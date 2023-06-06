Company.destroy_all
User.destroy_all

require "csv"

filepath = Rails.root.join("db", "DB_entrepreneurs.csv")
db_projects = Rails.root.join("db", "DB_projects.csv")
db_main_projects = Rails.root.join("db", "DB_main_projects.csv")

# Particuliers
puts "Creation of users..."
users = []
camille = User.create(email: "camille.dion@gmail.com", password: "123456", first_name: "Camille", last_name: "Dion", phone_number: "0611223344")
users << david = User.create!(email: "serrano.david.liaca@gmail.com", password: "123456", first_name: "David", last_name: "Serrano", phone_number: "0611223366")
users << amal = User.create!(email: "amal.rabbani@gmail.com", password: "123456", first_name: "Amal", last_name: "Rabbani", phone_number: "0611223377")
users << boubou = User.create!(email: "boubouboubs@gmail.com", password: "123456", first_name: "Stéphanie", last_name: "Boubou", phone_number: "0611223388")
users << celine = User.create!(email: "celine.chader@gmail.com", password: "123456", first_name: "Céline", last_name: "Chader", phone_number: "0611223399")
puts "#{users.size} users created!"

camille.photo.attach(io: File.open('app/assets/images/camille.jpg'), filename: "#{camille.first_name}.jpg")
celine.photo.attach(io: File.open('app/assets/images/celine.jpg'), filename: "#{celine.first_name}.jpg")
boubou.photo.attach(io: File.open('app/assets/images/boubou.jpg'), filename: "#{boubou.first_name}.jpg")
amal.photo.attach(io: File.open('app/assets/images/amal.jpg'), filename: "#{amal.first_name}.jpg")
david.photo.attach(io: File.open('app/assets/images/david.jpg'), filename: "#{david.first_name}.jpg")

# Entrepreneurs entreprises
puts "parsing CSV companies"
CSV.foreach(filepath, headers: :first_row, col_sep: ";") do |row|
  address = "#{row["Address"]}, #{row["Postcode"]}, #{row["City"]}"
  company = Company.create!(name: row[0], address: address, creation_date: row["creation_date" ])
  user = User.create!(email: row["Email"], company: company, password: "123456", phone_number: row["Phone_number"], first_name: row["First_name"], last_name: row["Last_name"])
end
puts "CSV parsed!!!"

# Main company 2 projects
puts "creation of main_company_projects"
CSV.foreach(db_main_projects, headers: :first_row, col_sep: ";") do |row|
  address = "#{row["Address"]}, #{row["Postcode"]}, #{row["City"]}"
  main_company_project = Project.create!(address: address, surface: row["Surface"], user: camille)
  ProjectCompany.create(project: main_company_project, company: Company.first)
end

# Projects A FAIRE DEMAIN.
# puts "creation of projects"
# CSV.foreach(db_projects, headers: :first_row, col_sep: ";") do |row|
#   address = "#{row["Address"]}, #{row["Postcode"]}, #{row["City"]}"
#   projects = Project.create!(address: address, surface: row["Surface"], user: user)
# end


# # projects.each do |project|
# #   project = Project.create!(project)
# #   project.user = users.sample
# #   project.save!
# #   project.companies << Company.where.not(id: Company.first.id).sample
# # end

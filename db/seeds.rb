Company.destroy_all
User.destroy_all

require "csv"
require "open-uri"
require "date"

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
puts "#{users.size} users created, seedons mes braves!"

camille.photo.attach(io: URI.open('https://res.cloudinary.com/dtxjrhsbk/image/upload/v1686144517/users/camille_rblw3n.jpg'), filename: "#{camille.first_name}.jpg")
celine.photo.attach(io: URI.open('https://res.cloudinary.com/dtxjrhsbk/image/upload/v1686144517/users/celine_iukwgc.png'), filename: "#{celine.first_name}.jpg")
boubou.photo.attach(io: URI.open('https://res.cloudinary.com/dtxjrhsbk/image/upload/v1686144517/users/boubou_ktspsm.jpg'), filename: "#{boubou.first_name}.jpg")
amal.photo.attach(io: URI.open('https://res.cloudinary.com/dtxjrhsbk/image/upload/v1686144516/users/amal_jiocgl.jpg'), filename: "#{amal.first_name}.jpg")
david.photo.attach(io: URI.open('https://res.cloudinary.com/dtxjrhsbk/image/upload/v1686144516/users/david_xdat6x.jpg'), filename: "#{david.first_name}.jpg")

# Entrepreneurs entreprises
puts "parsing CSV companies"
CSV.foreach(filepath, headers: :first_row, col_sep: ";") do |row|
  address = "#{row["Address"]}, #{row["Postcode"]}, #{row["City"]}"
  company = Company.create!(
    name: row[0],
    description: row["Description"],
    address: address,
    creation_date: row["creation_date"]
  )

  logo = row['Logo'].split(',').map { |url| url.strip }
  logo.each do |url|
    file = URI.open(url)
    company.logo.attach(io: file, filename: "nes.png", content_type: "image/png")
    company.save!
  end

  user = User.create!(
    email: row["Email"],
    company: company,
    password: "123456",
    phone_number: row["Phone_number"],
    first_name: row["First_name"],
    last_name: row["Last_name"]
  )
end
puts "CSV parsed!!!"

# Main company 2 projects
puts "parsing of main projects, projects company, reviews"
CSV.foreach(db_main_projects, headers: :first_row, col_sep: ";") do |row|
  address = "#{row["Address"]}, #{row["Postcode"]}, #{row["City"]}"
  p row["Visit_date"]
  main_company_project = Project.create!(
    property_type: row[0],
    address: address,
    surface: row["Surface"],
    user: users.sample,
    renovation_type: Project::RENOVATION_TYPE[row["Renovation_type"].to_i],
    visit_date: Date.parse(row["Visit_date"])
  )

  photo_urls = row['link_to_photos'].split(',').map { |url| url.strip }
  photo_urls.each do |url|
    file = URI.open(url)
    main_company_project.photos.attach(io: file, filename: "nes.png", content_type: "image/png")
    main_company_project.save
  end

  projectcompany = ProjectCompany.create(
    project: main_company_project,
    company: Company.first
  )
  Review.create!(
    project_company: projectcompany,
    rating: row["Rating"],
    comment: row["Reviews"]
  )
end
puts "CSV parsed"

puts "parsing of secondary projects, projects companies, reviews"
CSV.foreach(db_projects, headers: :first_row, col_sep: ";").with_index do |row, index|
  address = "#{row["Address"]}, #{row["Postcode"]}, #{row["City"]}"
  project = Project.create!(
    property_type: row[0],
    address: address,
    surface: row["Surface"],
    user: users.sample,
    renovation_type: Project::RENOVATION_TYPE[row["Renovation_type"].to_i],
    visit_date: Date.parse(row["Visit_date"])
  )
  photo_urls = row['link_to_photos'].split(',').map { |url| url.strip }
  photo_urls.each do |url|
    file = URI.open(url)
    project.photos.attach(io: file, filename: "nes.png", content_type: "image/png")
    project.save
  end

  projectcompany = ProjectCompany.create(
    project: project,
    company: Company.order(:created_at)[index + 1]
  )

  Review.create!(
    project_company: projectcompany,
    rating: row["Rating"],
    comment: row["Reviews"],
    created_at: Time.now - rand(5..50).days
  )
end
puts "CSV parsed"

puts "all done, nothing to see, go work now or go to sleep!"

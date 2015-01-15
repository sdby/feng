namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    admin=Employee.create!(name:"Example Employee", email:"example@google.com", phone:"23987", resume:"abundant experience", attachment:"cv.doc", password:"foobar", password_confirmation:"foobar")
    admin.toggle!(:admin)
  	99.times do |n|
  	  name=Faker::Name.name
  	  email="example-#{n+1}@google.com"
  	  password="foobar"
  	  Employee.create!(name:name, email:email, phone:"323298", resume:"abundant experience", attachment:"cv.doc", password:password, password_confirmation:password)
  	end

    admin=Employer.create!(name:"Example Employer", email:"example@apple.com", address:"888 renming rd", contact:"wangling", phone:"3298", password:"foobar", password_confirmation:"foobar")
    admin.toggle!(:admin)
    99.times do |n|
      name=Faker::Name.name
      email="company-#{n+1}@apple.com"
      password="foobar"
      Employer.create!(name:name, email:email, address:"999 huai hai rd", contact:"han zheng", phone:"090983", password: password, password_confirmation: password)
    end
  end
end
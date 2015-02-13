namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_employees
    make_employers
    make_jobs
    make_applications
  end
end

    def make_employees
      admin=Employee.create!(name:"Example Employee", email:"example@google.com", phone:"23987", resume:"abundant experience", attachment:"cv.doc", password:"foobar", password_confirmation:"foobar")
      admin.toggle!(:admin)
      99.times do |n|
        name=Faker::Name.name
        email="example-#{n+1}@google.com"
        password="foobar"
        Employee.create!(name:name, email:email, phone:"323298", resume:"abundant experience", attachment:"cv.doc", password:password, password_confirmation:password)
      end
    end

    def make_employers
      admin=Employer.create!(name:"Example Employer", email:"example@apple.com", address:"888 renming rd", contact:"wangling", phone:"3298", password:"foobar", password_confirmation:"foobar")
      admin.toggle!(:admin)
      99.times do |n|
        name=Faker::Name.name
        email="company-#{n+1}@apple.com"
        password="foobar"
        Employer.create!(name:name, email:email, address:"999 huai hai rd", contact:"han zheng", phone:"090983", password: password, password_confirmation: password)
      end
    end

    def make_jobs
      employers=Employer.all(limit: 6)
      50.times do |n|
        title="job title #{n+1}"
        description=Faker::Lorem.sentence(5)
        employers.each {|employer| employer.jobs.create!(title: title, description: description)}
      end
    end

    def make_applications
      opennings=Job.all[0..49]

      employees=Employee.all
      employee=employees.first
      applicants=employees[1..39]
      
      opennings.each{|openning| employee.apply!(openning)}
      applicants.each{|applicant| applicant.apply!(opennings.first)}
    end

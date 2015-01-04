FactoryGirl.define do
  factory :employee do
  	sequence(:name){|n| "Person#{n}"}
  	sequence(:email){|n| "person_#{n}@example.com"}
  	sequence(:phone){|n| "3298789"}
  	sequence(:resume){|n| "I have abundant experience"}
  	sequence(:attachment){|n| "mycv.pdf"}
  	password "foobar"
  	password_confirmation "foobar"

  	factory :admin do
  	  admin true
  	end
  end

  factory :employer do
    name "John Chang"
    email "john@ibm.com"
    address "huai hai rd"
    contact "john"
    phone "23432"
    password "foobar"
    password_confirmation "foobar"
  end
end
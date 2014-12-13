FactoryGirl.define do
  factory :employee do
  	name "michael johnson"
  	email "mjsd@example.com"
  	phone "232323"
  	resume "this is his previous experience"
  	attachment "mycv.doc"
  	password "foobar"
  	password_confirmation "foobar"
  end
end
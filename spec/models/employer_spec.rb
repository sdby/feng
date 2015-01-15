# == Schema Information
#
# Table name: employers
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  email      :string(255)
#  address    :string(255)
#  contact    :string(255)
#  phone      :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

require 'spec_helper'

describe Employer do

  before do
  	@employer=Employer.new(name: "synermax", email: "ben@synermax.com", address: "nanjing lu 888", contact: "wang ling", phone: "3898", password: "foobar", password_confirmation: "foobar")
  end

  subject {@employer}

  it {should respond_to(:name)}
  it {should respond_to(:email)}
  it {should respond_to(:address)}
  it {should respond_to(:contact)}
  it {should respond_to(:phone)}

  it {should respond_to(:password_digest)}

  it {should respond_to(:password)}
  it {should respond_to(:password_confirmation)}

  it {should respond_to(:remember_token)}

  it {should respond_to(:admin)}
  it {should respond_to(:authenticate)}

  it {should be_valid}
  it {should_not be_admin}

  describe "with admin attribute set to true" do
    before{@employer.toggle!(:admin)}

    it{should be_admin}
  end

  describe "when name is not present" do
  	before {@employer.name=""}
  	it {should_not be_valid}
  end

  describe "when email is not present" do
  	before {@employer.email=""}
  	it {should_not be_valid}
  end

  describe "when name is too long" do
  	before {@employer.name="a"*51}
  	it {should_not be_valid}
  end

  describe "when email format is invalid" do
  	it "should be invalid" do
  	  addresses=%w[user@foo,com user_at_foo.org example.user@foo. foo@bar_baz.com foo@bar_baz.com]
  	  addresses.each do |invalid_address|
  	  	@employer.email=invalid_address
  	  	@employer.should_not be_valid
  	  end
  	end
  end

  describe "when email format is valid" do
  	it "should be valid" do
  	  addresses=%w[user@foo.COM A_US-ER@f.b.org frst.1st@foo.jp a+b@baz.cn]
  	  addresses.each do |valid_address|
  	  	@employer.email=valid_address
  	  	@employer.should be_valid
  	  end
  	end
  end

  describe "when email address is already taken" do
  	before do
  	  employer_with_same_email=@employer.dup
  	  employer_with_same_email.email=@employer.email.upcase
  	  employer_with_same_email.save
  	end

  	it {should_not be_valid}
  end

  describe "when password is not present" do
    before {@employer.password=@employer.password_confirmation=""}
    it {should_not be_valid}
  end

  describe "when password doesn't match confirmation" do
    before {@employer.password_confirmation="mismatch"}
    it {should_not be_valid}
  end

  describe "when password confirmation is nil" do
    before {@employer.password_confirmation=nil}
    it {should_not be_valid}
  end

  describe "with a password that's too short" do
    before {@employer.password=@employer.password_confirmation="a"*5}
    it {should be_invalid}
  end

  describe "return value of authenticate method" do
    before {@employer.save}
    let(:found_employer){Employer.find_by_email(@employer.email)}

    describe "with valid password" do
      it {should==found_employer.authenticate(@employer.password)}
    end

    describe "with invalid password" do
      let(:employer_for_invalid_password){found_employer.authenticate("invalid")}
      it {should_not==employer_for_invalid_password}
      specify {employer_for_invalid_password.should be_false}
    end
  end

  describe "remember_token" do
    before {@employer.save}
    its(:remember_token){should_not be_blank}
  end
end

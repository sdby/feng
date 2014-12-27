# == Schema Information
#
# Table name: employees
#
#  id              :integer         not null, primary key
#  name            :string(255)
#  email           :string(255)
#  phone           :string(255)
#  resume          :text
#  attachment      :string(255)
#  created_at      :datetime        not null
#  updated_at      :datetime        not null
#  password_digest :string(255)
#  remember_token  :string(255)
#  admin           :boolean         default(FALSE)
#

require 'spec_helper'

describe Employee do
  before do
    @employee = Employee.new(name:"Yi Feng", email:"yifeng@google.com", phone:"13818885555", resume:"This is my professional experience", attachment:"cv.doc", password:"foobar", password_confirmation:"foobar")
  end

  subject {@employee}

  it {should respond_to(:name)}
  it {should respond_to(:email)}
  it {should respond_to(:phone)}
  it {should respond_to(:resume)}
  it {should respond_to(:attachment)}

  it {should respond_to(:password_digest)}

  it {should respond_to(:password)}
  it {should respond_to(:password_confirmation)}

  it {should respond_to(:remember_token)}

  it {should respond_to(:admin)}

  it {should respond_to(:authenticate)}

  it {should be_valid}
  it {should_not be_admin}

  describe "with admin attribute set to true" do
    before {@employee.toggle!(:admin)}
    it {should be_admin}
  end

  describe "when name is not present" do
    before {@employee.name=""}
    it {should_not be_valid}
  end

  describe "when email is not present" do
    before {@employee.email=""}
    it {should_not be_valid}
  end

  describe "when name is too long" do
    before {@employee.name="a"*51}
    it {should_not be_valid}
  end

  describe "when email format is invalid" do
    it "should be invalid" do
      addresses=%w[user@foo,com user_at_foo.org example.user@foo. foo@bar_baz.com foo@bar+baz.com]
      addresses.each do |invalid_address|
        @employee.email=invalid_address
	@employee.should_not be_valid
      end
    end
  end

  describe "when email format is valid" do
    it "should be valid" do
      addresses=%w[user@foo.COM A_US-ER@f.b.org first.last@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        @employee.email=valid_address
	@employee.should be_valid
      end
    end
  end

  describe "when email address is already taken" do
    before do
      employee_with_same_email=@employee.dup
      employee_with_same_email.email=@employee.email.upcase
      employee_with_same_email.save
    end
    it {should_not be_valid}
  end

  describe "when password is not present" do
    before {@employee.password=@employee.password_confirmation=""}
    it {should_not be_valid}
  end

  describe "when password doesn't match confirmation" do
    before {@employee.password_confirmation="mismatch"}
    it {should_not be_valid}
  end

  describe "when password confirmation is nil" do
    before {@employee.password_confirmation=nil}
    it {should_not be_valid}
  end

  describe "with a password that's too short" do
    before {@employee.password=@employee.password_confirmation="a"*5}
    it {should be_invalid}
  end

  describe "return value of authenticate method" do
    before {@employee.save}
    let(:found_employee){Employee.find_by_email(@employee.email)}

    describe "with valid password" do
      it {should==found_employee.authenticate(@employee.password)}
    end

    describe "with invalid password" do
      let(:employee_for_invalid_password){found_employee.authenticate("invalid")}
      it {should_not==employee_for_invalid_password}
      specify {employee_for_invalid_password.should be_false}
    end
  end

  describe "remember_token" do
    before {@employee.save}
    its(:remember_token){should_not be_blank}
  end
end

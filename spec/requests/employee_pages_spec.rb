require 'spec_helper'

describe "EmployeePages" do

  subject {page}

  describe "" do
    let(:employee){FactoryGirl.create(:employee)}
    before {visit employee_path(employee)}

    it {should have_selector('h1', text:employee.name)}
  end

  describe "employee signup page" do
    before {visit employeesignup_path}
    it {should have_selector('h1', text:'Employee sign up')}
  end

  describe "employeesignup" do
    before {visit employeesignup_path}
    let(:submit){"Create my account"}

    describe "with invalid information" do
      it "should not create an employee" do
        expect {click_button submit}.not_to change(Employee, :count)
      end
    end

    describe "with valid information" do
      before do
        fill_in "Name", with:"bai li"
        fill_in "Email", with:"bai.li@google.com"
        fill_in "Phone", with:"32423479"
        fill_in "Resume", with:"I have abundant sales experience"
        fill_in "Attachment", with:"jl.doc"
        fill_in "Password", with:"foobar"
        fill_in "Confirmation", with:"foobar"
      end

      it "should create an employee" do
        expect {click_button submit}.to change(Employee, :count).by(1)
      end
    end
  end
end

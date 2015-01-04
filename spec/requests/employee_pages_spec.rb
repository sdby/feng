require 'spec_helper'

describe "EmployeePages" do

  subject {page}

  describe "index" do

    before(:all){30.times{FactoryGirl.create(:employee)}}
    after(:all){Employee.delete_all}

    let(:employee){FactoryGirl.create(:employee)}

    before(:each) do
      sign_in employee
      visit employees_path
    end

    it {should have_selector('h1', text: 'All employees')}

    describe "pagination" do
      it {should have_selector('div.pagination')}
      
      it "should list each employee" do
        Employee.paginate(page: 1).each do |employee|
        page.should have_selector('li', text: employee.name)
        end
      end
    end

    describe "delete links" do
      it {should_not have_link('delete')}

      describe "as an admin employee" do
        let(:admin){FactoryGirl.create(:admin)}
        before do
          sign_in admin
          visit employees_path
        end

        it {should have_link('delete', href: employee_path(Employee.first))}

        it "should be able to delete another employee" do
          expect {click_link('delete')}.to change(Employee, :count).by(-1)
        end

        it {should_not have_link('delete', href: employee_path(admin))}
      end
    end
  end

  describe "profile page" do
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

      describe "after saving the employee" do
        before {click_button submit}
        let(:employee){Employee.find_by_email('bai.li@google.com')}

        it {should have_link('Sign out')}
      end
    end
  end

  describe "edit" do
    let(:employee){FactoryGirl.create(:employee)}
    before do
      sign_in employee
      visit edit_employee_path(employee)
    end

    describe "page" do
      it {should have_selector('h1', text:"Update your profile")}
      it {should have_link('change', href:'http://en.gravatar.com/emails/')}
    end

    describe "with invalid information" do
      before {click_button "Save changes"}
      it {should have_content('error')}
    end

    describe "with valid information" do
      let(:new_name){"New Name"}
      let(:new_email){"new@example.com"}
      before do
        fill_in "Name", with: new_name
        fill_in "Email", with: new_email
        fill_in "Phone", with: employee.phone
        fill_in "Resume", with: employee.resume
        fill_in "Attachment", with: employee.attachment
        fill_in "Password", with: employee.password
        fill_in "Confirmation", with: employee.password_confirmation
        click_button "Save changes"
      end

      it {should have_selector('div.alert.alert-success')}
      it {should have_link('Sign out', href: signout_path)}

      specify {employee.reload.name.should==new_name}
      specify {employee.reload.email.should==new_email}
    end
  end
end

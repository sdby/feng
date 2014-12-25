require 'spec_helper'

describe "AuthenticationPages" do

  subject {page}

  describe "signin page" do
  	before {visit signin_path}

  	it {should have_selector('h1', text:'Sign in')}
  end

  describe "signin" do
  	before {visit signin_path}

  	describe "with invalid information" do
  	  before {click_button "Sign in"}
  	  it {should have_selector('div.alert.alert-danger', text:'Invalid')}

      describe "after visiting another page" do
        before {click_link "Home"}
        it {should_not have_selector('div.alert.alert-danger')}
      end
  	end

  	describe "with valid information" do
  	  let(:employee){FactoryGirl.create(:employee)}
      before {sign_in employee}

      it {should have_link('Employees', href: employees_path)}
  	  it {should have_link('Profile', href: employee_path(employee))}
      it {should have_link('Settings', href: edit_employee_path(employee))}
  	  it {should have_link('Sign out', href: signout_path)}
  	  it {should_not have_link('Sign in', href: signin_path)}

      describe "followed by signout" do
        before {click_link "Sign out"}
        it {should have_link('Sign in')}
      end
  	end
  end

  describe "authorization" do

    describe "for non-signed-in employees" do
      let(:employee){FactoryGirl.create(:employee)}

      describe "when attempting to visit a protected page" do
        before do
          visit edit_employee_path(employee) # Since the employee isn't signed in, the page will be forwarded to signin page
          fill_in "Email", with: employee.email
          fill_in "Password", with: employee.password
          click_button "Sign in"
        end

        describe "after signing in" do
          it "should render the desired protected page" do
            page.should have_selector('h1', text: 'Update your profile')
          end
        end
      end

      describe "in the Employees controller" do

        describe "visiting the edit page" do
          before {visit edit_employee_path(employee)}
          it {should have_selector('h1', text: 'Sign in')}
        end

        describe "submitting to the update action" do
          before {put employee_path(employee)}
          specify {response.should redirect_to(signin_path)}
        end

        describe "visiting the employee index" do
          before {visit employees_path}
          it {should have_selector('h1', text: 'Sign in')}
        end
      end
    end

    describe "as wrong employee" do
      let(:employee){FactoryGirl.create(:employee)}
      let(:wrong_employee){FactoryGirl.create(:employee, email: "wrong@example.com")}
      before {sign_in employee}

      describe "visiting Employees#edit page" do
        before {visit edit_employee_path(wrong_employee)}
        it {should_not have_selector('h1', text: 'Update your profile')}
      end

      describe "submitting a PUT request to the Employees#update action" do
        before {put employee_path(wrong_employee)}
        specify {response.should redirect_to(root_path)}
      end
    end

    describe "as non-admin employee" do
      let(:employee){FactoryGirl.create(:employee)}
      let(:non_admin){FactoryGirl.create(:employee)}

      before {sign_in non_admin}

      describe "submitting a DELETE request to the Employees#destroy action" do
        before {delete employee_path(employee)}
        specify {response.should redirect_to(root_path)}
      end
    end
  end
end

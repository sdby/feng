require 'spec_helper'

describe "Employer pages" do

  subject {page}

  describe "index" do

    before(:all){30.times{FactoryGirl.create(:employer)}}
    after(:all){Employer.delete_all}

    before(:each) do
      sign_in FactoryGirl.create(:employer)
      visit employers_path
    end

    it{should have_selector('h1', text: 'All employers')}

    describe "pagination" do
      it{should have_selector('div.pagination')}

      it "should list each employer" do
        Employer.paginate(page: 1).each do |employer|
          page.should have_selector('li', text: employer.name)
        end
      end
    end

    describe "delete links" do
      it{should_not have_link('delete')}

      describe "as an admin employer" do
        let(:employer_admin){FactoryGirl.create(:employer_admin)}
        before do
          sign_in employer_admin
          visit employers_path
        end

        it{should have_link('delete', href: employer_path(Employer.first))}
        it "should be able to delete another employer" do
          expect{click_link('delete')}.to change(Employer, :count).by(-1)
        end
        it{should_not have_link('delete', href: employer_path(employer_admin))}
      end
    end
  end

  describe "profile page" do
  	let(:employer){FactoryGirl.create(:employer)}

    let!(:j1){FactoryGirl.create(:job, employer: employer, title: "software engineer", description: "who will develop web application")}
    let!(:j2){FactoryGirl.create(:job, employer: employer, title: "ror developer", description: "who will developer ror app")}

  	before {visit employer_path(employer)}

  	it {should have_selector('h1', text: employer.name)}

    describe "jobs" do
      it{should have_content(j1.title)}
      it{should have_content(j2.title)}
      it{should have_content(employer.jobs.count)}
    end
  end

  describe "Employer signup page" do
  	before {visit employersignup_path}

  	it {should have_selector('h1', text: 'Employer sign up')}
  end

  describe "employer signup" do
    before {visit employersignup_path}
    let(:submit){"Create my account"}

    describe "with invalid information" do
      it "should not create a employer" do
        expect {click_button submit}.not_to change(Employer, :count)
      end
    end

    describe "with valid information" do
      before do
        fill_in "Name", with: "Example Employer"
        fill_in "Email", with: "employer@example.com"
        fill_in "Address", with: "people square"
        fill_in "Contact", with: "Apple corporation"
        fill_in "Phone", with: "234898"
        fill_in "Password", with: "foobar"
        fill_in "Confirmation", with: "foobar"
      end

      it "should create a employer" do
        expect {click_button submit}.to change(Employer, :count).by(1)
      end

      describe "after saving the employer" do
        before {click_button submit}
        let(:employer){Employer.find_by_email('employer@example.com')}

        it{should have_selector('h1', text: employer.name)}
        it{should have_selector('div.alert.alert-success', text: 'Welcome')}
        it{should have_link('Sign out')}
      end
    end
  end

  describe "edit" do
    let(:employer){FactoryGirl.create(:employer)}
    before do
      sign_in employer
      visit edit_employer_path(employer)
    end

    describe "page" do
      it{should have_selector('h1', text: "Update your profile")}
      it{should have_link('change', href: 'http://en.gravatar.com/emails/')}
    end

    describe "with invalid information" do
      before{click_button "Save changes"}

      it{should have_content('error')}
    end

    describe "with valid information" do
      let(:new_name){"New Name"}
      let(:new_email){"new@synergy.com"}
      before do
        fill_in "Name", with: new_name
        fill_in "Email", with: new_email
        fill_in "Address", with: employer.address
        fill_in "Contact", with: employer.contact
        fill_in "Phone", with: employer.phone
        fill_in "Password", with: employer.password
        fill_in "Confirm", with: employer.password
        click_button "Save changes"
      end

      it {should have_selector('div.alert.alert-success')}
      it {should have_link('Sign out', href: signout_path)}

      specify {employer.reload.name.should==new_name}
      specify {employer.reload.email.should==new_email}
    end
  end
end
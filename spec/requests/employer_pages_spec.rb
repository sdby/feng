require 'spec_helper'

describe "Employer pages" do

  subject {page}

  describe "profile page" do
  	let(:employer){FactoryGirl.create(:employer)}
  	before {visit employer_path(employer)}

  	it {should have_selector('h1', text: employer.name)}
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
end
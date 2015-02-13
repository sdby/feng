require 'spec_helper'

describe "Static pages" do

  subject{page}

  describe "Home page" do
  	describe "for signed-in employers" do
  	  let(:employer){FactoryGirl.create(:employer)}
  	  before do
  	  	FactoryGirl.create(:job, employer: employer, title: "Sales Manager", description: "who will take the team quota in GCG territory")
  	  	FactoryGirl.create(:job, employer: employer, title: "Technical Manager", description: "with software development background, who needs to manage engineer team")
  	  	sign_in employer
  	  	visit root_path
  	  end

  	  it "should render the employer's feed" do
  	  	employer.feed.each do |job|
  	  	  page.should have_selector("li##{job.id}", text: job.title)
  	  	end
  	  end
  	end

    describe "for signed-in employees" do
      let(:employee){FactoryGirl.create(:employee)}
      let(:employer){FactoryGirl.create(:employer)}
      before do
        FactoryGirl.create(:job, employer: employer, title: "Sales Manager", description: "who will take the team quota in GCG territory")
        FactoryGirl.create(:job, employer: employer, title: "Technical Manager", description: "with software development background, who needs to manage engineer team")
        sign_in employee
        visit root_path
      end

      it "should display applied_jobs counts" do
        employee.apply!(employer.jobs.first)
        employee.apply!(employer.jobs.last)

        visit root_path

        page.should have_link("2 applications", href: jobs_employee_path(employee))
      end
    end
  end
end
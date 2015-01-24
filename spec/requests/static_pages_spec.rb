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
  end
end
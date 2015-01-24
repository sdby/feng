require 'spec_helper'

describe "JobPages" do
  # describe "GET /job_pages" do
  #   it "works! (now write some real specs)" do
  #     # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
  #     get job_pages_index_path
  #     response.status.should be(200)
  #   end
  # end

  subject {page}

  let(:employer){FactoryGirl.create(:employer)}
  before{sign_in employer}

  describe "job creation" do
  	before{visit root_path}

  	describe "with invalid information" do
  	  it "should not create a job" do
  	  	expect{click_button "Post"}.should_not change(Job, :count)
  	  end

  	  describe "error messages" do
  	  	before{click_button "Post"}
  	  	it{should have_content('error')}
  	  end
  	end

  	describe "with valid information" do
  	  before do
  	  	fill_in 'job_title', with: "Client Manager"
  	  	fill_in 'job_description', with: "manange all the territory client reps and be on team quota"
  	  end
  	  it "should create a job" do
  	  	expect{click_button "Post"}.should change(Job, :count).by(1)
  	  end
  	end
  end

  describe "job destruction" do
    before{FactoryGirl.create(:job, employer: employer)}

    describe "as correct employer" do
      before{visit root_path}

      it "should delete a job" do
        expect{click_link "delete"}.should change(Job, :count).by(-1)
      end
    end
  end
end

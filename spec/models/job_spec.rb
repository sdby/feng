require 'spec_helper'

describe Job do
  let(:employer){FactoryGirl.create(:employer)}
  before do
    @job=employer.jobs.build(title:"Team Leader", description:"who will be responsible for successful project delivery")
  end

  subject{@job}

  it{should respond_to(:title)}
  it{should respond_to(:description)}
  it{should respond_to(:status)}
  it{should respond_to(:employer_id)}

  it{should respond_to(:employer)}
  its(:employer){should==employer}

  it{should be_valid}

  describe "when employer_id is not present" do
    before{@job.employer_id=nil}
    it{should_not be_valid}
  end

  describe "accessible attributes" do
    it "should not allow access to employer_id" do
      expect do
        Job.new(employer_id: employer.id)
      end.should raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end
  end

  describe "with blank title" do
    before{@job.title=""}
    it{should_not be_valid}
  end

  describe "with blank description" do
    before{@job.description=""}
    it{should_not be_valid}
  end
end

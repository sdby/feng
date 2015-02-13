require 'spec_helper'

describe Application do

  let(:employee){FactoryGirl.create(:employee)}
  let(:job){FactoryGirl.create(:job)}
  let(:application){employee.applications.build(job_id: job.id)}

  subject{application}

  it{should be_valid}

  describe "accessible attributes" do
  	it "should not allow access to employee_id" do
  	  expect do
  	  	Application.new(employee_id: employee.id)
  	  end.should raise_error(ActiveModel::MassAssignmentSecurity::Error)
  	end
  end

  describe "employee methods" do
  	it{should respond_to(:employee)}
  	it{should respond_to(:job)}
  	its(:employee){should==employee}
  	its(:job){should==job}
  end

  describe "when job id is not present" do
    before{application.job_id=nil}
    it{should_not be_valid}
  end

  describe "when employee id is not present" do
    before{application.employee_id=nil}
    it{should_not be_valid}
  end
end

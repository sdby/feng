class Application < ActiveRecord::Base
  attr_accessible :job_id

  belongs_to :employee, class_name: "Employee"
  belongs_to :job, class_name: "Job"

  validates :employee_id, presence: true
  validates :job_id, presence: true
end

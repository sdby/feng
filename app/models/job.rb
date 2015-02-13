class Job < ActiveRecord::Base
  attr_accessible :description, :title
  belongs_to :employer

  has_many :reverse_applications, foreign_key: "job_id", class_name: "Application", dependent: :destroy
  has_many :employees, through: :reverse_applications, source: :employee

  validates :title, presence: true, length: {maximum: 25}
  validates :description, presence: true, length: {maximum: 1000}

  validates :employer_id, presence: true
  default_scope order: 'jobs.created_at DESC'
end

class Job < ActiveRecord::Base
  attr_accessible :description, :title
  belongs_to :employer

  validates :title, presence: true, length: {maximum: 25}
  validates :description, presence: true, length: {maximum: 1000}

  validates :employer_id, presence: true
  default_scope order: 'jobs.created_at DESC'
end

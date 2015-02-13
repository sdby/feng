# == Schema Information
#
# Table name: employees
#
#  id              :integer         not null, primary key
#  name            :string(255)
#  email           :string(255)
#  phone           :string(255)
#  resume          :text
#  attachment      :string(255)
#  created_at      :datetime        not null
#  updated_at      :datetime        not null
#  password_digest :string(255)
#  remember_token  :string(255)
#  admin           :boolean         default(FALSE)
#

class Employee < ActiveRecord::Base
  attr_accessible :attachment, :email, :name, :phone, :resume, :password, :password_confirmation
  has_secure_password

  has_many :applications, foreign_key: "employee_id", dependent: :destroy

  has_many :applied_jobs, through: :applications, source: :job

  before_save {|employee| employee.email=email.downcase}
  before_save :create_remember_token

  validates :name, presence:true, length:{maximum:50}
  VALID_EMAIL_REGEX=/\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence:true, format:{with:VALID_EMAIL_REGEX}, uniqueness:{case_sensitive:false}
  validates :password, presence:true, length:{minimum:6}
  validates :password_confirmation, presence:true

  def applying?(job)
    applications.find_by_job_id(job.id)
  end

  def apply!(job)
    applications.create!(job_id: job.id)
  end

  def unapply!(job)
    applications.find_by_job_id(job).destroy
  end

  private
    def create_remember_token
      self.remember_token=SecureRandom.urlsafe_base64
    end
end

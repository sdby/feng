# == Schema Information
#
# Table name: employers
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  email      :string(255)
#  address    :string(255)
#  contact    :string(255)
#  phone      :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class Employer < ActiveRecord::Base
  attr_accessible :address, :contact, :email, :name, :phone, :password, :password_confirmation
  has_secure_password

  has_many :jobs, dependent: :destroy

  before_save {|employer| employer.email=email.downcase}

  before_save :create_remember_token

  validates :name, presence: true, length: {maximum: 50}
  VALID_EMAIL_REGEX=/\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}

  validates :password, presence: true, length: {minimum: 6}
  validates :password_confirmation, presence: true

  def feed
    # This is preliminary. See "Following employers" for the full implementation.
    Job.where("employer_id=?", id)
  end

  private
    def create_remember_token
      self.remember_token=SecureRandom.urlsafe_base64
    end
end

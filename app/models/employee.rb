# == Schema Information
#
# Table name: employees
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  email      :string(255)
#  phone      :string(255)
#  resume     :text
#  attachment :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class Employee < ActiveRecord::Base
  attr_accessible :attachment, :email, :name, :phone, :resume, :password, :password_confirmation
  has_secure_password

  before_save {|employee| employee.email=email.downcase}

  validates :name, presence:true, length:{maximum:50}
  VALID_EMAIL_REGEX=/\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence:true, format:{with:VALID_EMAIL_REGEX}, uniqueness:{case_sensitive:false}
  validates :password, presence:true, length:{minimum:6}
  validates :password_confirmation, presence:true
end
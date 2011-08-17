# == Schema Information
#
# Table name: administrators
#
#  id         :integer(4)      not null, primary key
#  username   :string(255)
#  email      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Administrator < ActiveRecord::Base

  attr_accessible :username, :email

  validates :username, :presence => true
  validates :email, :presence => true

end

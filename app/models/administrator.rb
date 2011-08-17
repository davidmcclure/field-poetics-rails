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

  # Accessors.
  attr_accessor :password
  attr_accessible :username, :email, :password, :password_confirmation

  # Regex for email validation.
  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  # Field validators.
  validates :username,
    :presence => true,
    :length => { :maximum => 50 },
    :uniqueness => { :case_sensitive => true }

  validates :email,
    :presence => true,
    :format => { :with => email_regex }

  validates :password,
    :presence => true,
    :confirmation => true,
    :length => { :within => 6..40 }

  # Callbacks.
  before_save :encrypt_password


  private

    def encrypt_password
      self.encrypted_password = encrypt(self.password)
    end

    def encrypt(string)
      string
    end

end

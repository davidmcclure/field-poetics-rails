# == Schema Information
#
# Table name: administrators
#
#  id                 :integer(4)      not null, primary key
#  username           :string(255)
#  email              :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#  encrypted_password :string(255)
#  is_superadmin      :boolean(1)      default(FALSE)
#  firstname          :string(255)
#  lastname           :string(255)
#

class Administrator < ActiveRecord::Base

  # Accessors.
  attr_accessor :password
  attr_accessible :username,
    :email,
    :is_superadmin,
    :password,
    :password_confirmation,
    :firstname,
    :lastname

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

  validates :firstname,
    :presence => true,
    :length => { :maximum => 50 }

  validates :lastname,
    :presence => true,
    :length => { :maximum => 50 }

  # Callbacks.
  before_save :encrypt_password

  # ** Table methods. ** #

  # Try to log in a username/passsword combination.
  def self.authenticate(username, submitted_password)
    administrator = find_by_username(username)
    if administrator.nil?
      return nil
    else
      if administrator.password_matches?(submitted_password)
        return administrator
      end
    end
  end

  # ** Row methods. ** #

  # Check to see if the admin's password matches the submitted password.
  def password_matches?(submitted_password)
    encrypt(submitted_password) == encrypted_password
  end

  private

    def encrypt_password
      self.salt = make_salt if new_record?
      self.encrypted_password = encrypt(self.password)
    end

    def encrypt(string)
      secure_hash("#{salt}--#{string}")
    end

    def make_salt
      secure_hash("#{Time.now.utc}--#{password}")
    end

    def secure_hash(string)
      Digest::SHA2.hexdigest(string)
    end

end

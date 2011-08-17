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

require 'spec_helper'

describe Administrator do

  before(:each) do
    @attributes = { :username => 'davidmcclure', :email => 'david.mcclure@virginia.edu' }
  end

  it "should create a new administrator given valid attributes" do
    Administrator.create!(@attributes)
  end

  it "should require a name" do
    no_username_admin = Administrator.new(@attributes.merge(:username => ''))
    no_username_admin.should_not be_valid
  end

  it "should require an email address" do
    no_email_admin = Administrator.new(@attributes.merge(:email => ''))
    no_email_admin.should_not be_valid
  end

end

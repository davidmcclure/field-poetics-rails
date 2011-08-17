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
    @attributes = { :username => "davidmcclure", :email => "david.mcclure@virginia.edu" }
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

  it "should reject usernames that are too long" do
    long_username = "a" * 51
    long_username_admin = Administrator.new(@attributes.merge(:username => long_username))
    long_username_admin.should_not be_valid
  end

  it "should accept valid email addresses" do
    addresses = %w[david@clever.org THE_DAVID@clever.cleverer.org david.clever@scholarslab.great]
    addresses.each do |address|
      valid_email_admin = Administrator.new(@attributes.merge(:email => address))
      valid_email_admin.should be_valid
    end
  end

  it "should reject invalid email addresses" do
    addresses = %w[david@clever,org THE_DAVID.cleverer.org david.clever@scholarslab.]
    addresses.each do |address|
      invalid_email_admin = Administrator.new(@attributes.merge(:email => address))
      invalid_email_admin.should_not be_valid
    end
  end

  it "should reject duplicate usernames" do
    Administrator.create!(@attributes)
    admin_with_duplicate_username = Administrator.new(@attributes)
    admin_with_duplicate_username.should_not be_valid
  end

  it "should allow differently cased by otherwise identical usernames" do
    Administrator.create!(@attributes)
    admin_with_differently_cased_username = Administrator.new(@attributes.merge(:username => "DaViDmCcLuRe"))
    admin_with_differently_cased_username.should be_valid
  end

end

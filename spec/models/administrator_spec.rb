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
#

require 'spec_helper'

describe Administrator do

  before(:each) do
    @attributes = {
      :username => "davidmcclure",
      :email => "david.mcclure@virginia.edu",
      :password => "poesypure",
      :password_confirmation => "poesypure"
    }
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

  it "should require a password" do
    Administrator.new(@attributes.merge(:password => "", :password_confirmation => "")).should_not be_valid
  end

  it "should require a matching confirmation" do
    Administrator.new(@attributes.merge(:password_confirmation => "poesyimpure")).should_not be_valid
  end

  it "should reject short passwords" do
    too_short_password = "a" * 5
    Administrator.new(@attributes.merge(:password => too_short_password, :password_confirmation => too_short_password)).
      should_not be_valid
  end

  it "should reject long passwords" do
    too_long_password = "a" * 41
    Administrator.new(@attributes.merge(:password => too_long_password, :password_confirmation => too_long_password)).
      should_not be_valid
  end

  describe "password encryption" do

    before(:each) do
      @administrator = Administrator.create!(@attributes)
    end

    it "should have an encrypted password attribute" do
      @administrator.should respond_to(:encrypted_password)
    end

    it "should set the encrypted password" do
      @administrator.encrypted_password.should_not be_blank
    end

  end

  describe "is_superadmin status" do

    it "should have a is_superadmin attribute" do
      Administrator.create!(@attributes).should respond_to(:is_superadmin)
    end

    it "should accept attributes when is_superadmin is set to true" do
      Administrator.new(@attributes.merge(:is_superadmin => true)).should be_valid
    end

    it "should create a non-superadmin admin by default" do
      @administrator = Administrator.create!(@attributes)
      @administrator.is_superadmin.should equal(false)
    end

    it "should create a superadmin when is_superadmin is set to true" do
      @administrator = Administrator.create!(@attributes.merge(:is_superadmin => true))
      @administrator.is_superadmin.should equal(true)
    end

  end

end

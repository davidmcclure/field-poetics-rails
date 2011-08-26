require 'spec_helper'

describe "Administrators" do

  describe "first administrator signup" do

    describe "failure" do

      it "should not create a new administrator" do
        lambda do
          visit welcome_path
          fill_in "Username", :with => ""
          fill_in "Password", :with => ""
          fill_in "Confirm", :with => ""
          fill_in "Email", :with => ""
          fill_in "First name", :with => ""
          fill_in "Last name", :with => ""
          click_button
          response.should render_template('/welcome')
          response.should have_selector('p.inline-errors', :count => 5)
        end.should_not change(Administrator, :count)
      end

    end

    describe "success" do

      it "should create a new administrator" do
        lambda do
          visit welcome_path
          fill_in "Username", :with => "davidmcclure"
          fill_in "Password", :with => "scholarslab"
          fill_in "Confirm", :with => "scholarslab"
          fill_in "Email", :with => "david.mcclure@virginia.edu"
          fill_in "First name", :with => "David"
          fill_in "Last name", :with => "McClure"
          click_button
          response.should render_template('/')
        end.should change(Administrator, :count).by(1)
      end

    end

  end

  describe "administrator login" do

    describe "failure" do

      it "should not log in an administrator without valid credentials" do
        @administrator = Factory(:administrator)
        visit signin_path
        fill_in "Username", :with => 'invalid'
        fill_in "Password", :with => 'invalid'
        click_button
        response.should render_template('/new')
        response.should have_selector('div.flash', :count => 1, :content => 'Invalid combination.')
        controller.should_not be_signed_in
      end

    end

    describe "success" do

      it "should log in an administrator with valid credentials" do
        @administrator = Factory(:administrator)
        visit signin_path
        fill_in "Username", :with => @administrator.username
        fill_in "Password", :with => @administrator.password
        click_button
        response.should render_template('/')
        controller.should be_signed_in
      end

    end

  end

end

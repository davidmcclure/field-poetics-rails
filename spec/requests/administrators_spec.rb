require 'spec_helper'

describe "Administrators" do

  describe "first administrator signup" do

    describe "failure" do

      it "should not create a new administrator" do
        lambda do
          visit welcome_path
          fill_in "Username", :with => ""
          fill_in "Password", :with => ""
          fill_in "Confirm Password", :with => ""
          fill_in "Email", :with => ""
          fill_in "First Name", :with => ""
          fill_in "Last Name", :with => ""
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
          fill_in "Confirm Password", :with => "scholarslab"
          fill_in "Email", :with => "david.mcclure@virginia.edu"
          fill_in "First Name", :with => "David"
          fill_in "Last Name", :with => "McClure"
          click_button
          response.should render_template('/')
        end.should change(Administrator, :count).by(1)
      end

    end

  end

end

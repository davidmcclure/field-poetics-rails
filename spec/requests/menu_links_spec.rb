require 'spec_helper'

describe "Menu links" do

  describe "first administrator signup" do

    it "should not display the menu links" do
      visit root_path
      response.should_not have_selector('nav')
    end

  end

  describe "administrator login" do

    it "should not display the menu links" do
      @administrator = Factory(:administrator)
      visit root_path
      response.should_not have_selector('nav')
    end

  end

  describe "logged in administrator" do

    before(:each) do
      @administrator = Factory(:administrator)
      visit signin_path
      fill_in :username, :with => @administrator.username
      fill_in :password, :with => @administrator.password
      click_button
    end

    it "should display the menu links" do
      visit root_path
      response.should have_selector('nav')
    end

    it "should show the administrator's username" do
      visit root_path
      response.should have_selector('div#current-administrator span', :content => @administrator.username)
    end

    it "should display the logout link" do
      visit root_path
      response.should have_selector('a#logout', :content => 'logout', :href => signout_path)
    end

  end

end

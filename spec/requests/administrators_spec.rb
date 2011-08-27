require 'spec_helper'

describe "Administrators" do

  describe "first administrator signup" do

    describe "failure" do

      it "should not create a new administrator" do
        lambda do
          test_first_administrator_invalid_credentials
        end.should_not change(Administrator, :count)
      end

      it "should re-render the welcome template" do
        test_first_administrator_invalid_credentials
        response.should render_template('/welcome')
      end

      it "should display error messages" do
        test_first_administrator_invalid_credentials
        response.should have_selector('p.inline-errors', :count => 5)
      end

    end

    describe "success" do

      it "should create a new administrator" do
        lambda do
          test_first_administrator_valid_credentials
        end.should change(Administrator, :count).by(1)
      end

      it "should render the 'Home' template" do
        test_first_administrator_valid_credentials
        response.should render_template('/')
      end

    end

  end

  describe "administrator login" do

    describe "failure" do

      it "should not log in an administrator without valid credentials" do
        @administrator = Factory(:administrator)
        test_invalid_login
        controller.should_not be_signed_in
      end

      it "should re-render the login template" do
        test_invalid_login
        response.should render_template('/new')
      end

      it "should flash an error message" do
        test_invalid_login
        response.should have_selector('div.flash', :count => 1, :content => 'Invalid combination.')
      end

    end

    describe "success" do

      it "should log in an administrator with valid credentials" do
        test_valid_login(Factory(:administrator))
        response.should render_template('/')
        controller.should be_signed_in
      end

    end

  end

end

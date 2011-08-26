require 'spec_helper'

describe MainController do
  render_views

  describe "GET 'index'" do

    it "should redirect to the first administrator signup page if there are no administrators in the database" do
      get :index
      response.should redirect_to(welcome_path)
    end

    it "should redirect to the login page if the administrator is not logged in" do
      @administrator = Factory(:administrator)
      get :index
      response.should redirect_to(signin_path)
    end

    it "should not redirect if the administrator is logged in" do
      test_sign_in(Factory(:administrator))
      get :index
      response.should_not redirect_to(signin_path)
    end

  end

end

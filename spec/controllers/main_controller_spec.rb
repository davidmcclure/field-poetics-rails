require 'spec_helper'

describe MainController do
  render_views

  describe "GET 'index'" do

    it "should be successful" do
      get 'index'
      response.should be_success
    end

    it "should redirect to the first administrator signup page if there are no administrators in the database"

    it "should redirect to the login page if the administrator is not logged in"

  end

end

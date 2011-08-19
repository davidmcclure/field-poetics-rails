require 'spec_helper'

describe AdministratorsController do
  render_views

  describe "GET 'first'" do

    it "should be successful" do
      get :first
      response.should be_success
    end

    it "should have the right title" do
      get :first
      response.should have_selector("title", :content => "Welcome")
    end

  end

end

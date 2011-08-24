require 'spec_helper'

describe SessionsController do
  render_views

  describe "GET 'new'" do

    it "should be successful" do
      get :new
      response.should be_success
    end

    it "should have the right title" do
      get :new
      response.should have_selector("title", :content => "Sign In")
    end

  end

  describe "POST 'create'" do

    describe "invalid signin" do

      before(:each) do
        @attributes = { :username => "wronguser", :password => "invalid" }
      end

      it "should re-render the sign in page" do
        post :create, :session => @attributes
        response.should render_template('new')
      end

      it "should have the right title" do
        post :create, :session => @attributes
        response.should have_selector("title", :content => "Sign In")
      end

    end

  end

end

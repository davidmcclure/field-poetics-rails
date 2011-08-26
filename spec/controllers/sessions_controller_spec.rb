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
        post :create, :administrator => @attributes
        response.should render_template('new')
      end

      it "should have the right title" do
        post :create, :administrator => @attributes
        response.should have_selector("title", :content => "Sign In")
      end

      it "should have a flash.now message" do
        post :create, :administrator => @attributes
        flash.now[:error].should =~ /invalid/i
      end

    end

    describe "with valid credentials" do

      before(:each) do
        @administrator = Factory(:administrator)
        @attributes = { :username => @administrator.username, :password => @administrator.password }
      end

      it "should sign the administrator in" do
        post :create, :administrator => @attributes
        controller.current_administrator.should == @administrator
        controller.should be_signed_in
      end

      it "should redirect to the 'Home' page" do
        post :create, :administrator => @attributes
        response.should redirect_to(root_path)
      end

    end

  end

  describe "DELETE 'destroy'" do

    it "should sign a user out" do
      test_sign_in(Factory(:administrator))
      delete :destroy
      controller.should_not be_signed_in
      response.should redirect_to(root_path)
    end

  end

end

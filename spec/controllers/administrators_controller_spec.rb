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

  describe "POST 'create'" do

    describe "failure" do

      before(:each) do
        @attributes = {
          :username => "",
          :password => "",
          :password_confirmation => "",
          :email => "",
          :firstname => "",
          :lastname => "",
          :is_superuser => 1
        }
      end

      it "should not create a user" do
        lambda do
          post :create, :administrator => @attributes
        end.should_not change(Administrator, :count)
      end

      it "should have the right title" do
        post :create, :administrator => @attributes
        response.should have_selector("title", :content => "Welcome")
      end

      it "should render the 'first' page" do
        post :create, :administrator => @attributes
        response.should render_template('first')
      end

    end

    describe "success" do

      before(:each) do
        @attributes = {
          :username => "davidmcclure",
          :password => "scholarslab",
          :password_confirmation => "scholarslab",
          :email => "david.mcclure@virginia.edu",
          :firstname => "David",
          :lastname => "McClure",
          :is_superadmin => 1
        }
      end

      it "should create an administrator" do
        lambda do
          post :create, :administrator => @attributes
        end.should change(Administrator, :count).by(1)
      end

      it "should create an administrator that is a super administrator" do
        post :create, :administrator => @attributes
        @administrator = Administrator.first
        @administrator.is_superadmin.should equal(true)
      end

      it "should automatically log the new administrator in" do
        post :create, :administrator => @attributes
        @administrator = Administrator.first
        controller.current_administrator.should == @administrator
        controller.should be_signed_in
      end

      it "should redirect to the 'Home' screen" do
        post :create, :administrator => @attributes
        response.should redirect_to(root_path)
      end

    end

  end

end

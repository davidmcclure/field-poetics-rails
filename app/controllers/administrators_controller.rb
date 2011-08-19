class AdministratorsController < ApplicationController

  def first
    @administrator = Administrator.new
    @title = "Welcome"
  end

end

class AdministratorsController < ApplicationController

  def first
    @administrator = Administrator.new
    @title = "Welcome"
  end

  def create
    @administrator = Administrator.new(params[:administrator])
    if @administrator.save
      # Do success.
    else
      @title = "Welcome"
      render 'first'
    end
  end

end

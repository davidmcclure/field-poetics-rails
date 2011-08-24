class MainController < ApplicationController

  def index
    @title = 'Home'
  end

  private

    def is_administrator
      if Administrator.count == 0
        # redirect to first admin signup
      else
        @administrator = Administrator.find(params[:id])
        # redirect to login page
      end
    end

end

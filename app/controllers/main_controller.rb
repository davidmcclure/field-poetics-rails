class MainController < ApplicationController

  before_filter :authenticate

  def index
    @title = 'Home'
  end

  private

    def authenticate
      if Administrator.count == 0
        redirect_to welcome_path
      else
        deny_access unless signed_in?
      end
    end

end

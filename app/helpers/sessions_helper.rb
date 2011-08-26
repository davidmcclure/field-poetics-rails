module SessionsHelper

  def sign_in(administrator)
    cookies.permanent.signed[:remember_token] = [administrator.id, administrator.salt]
    self.current_administrator = administrator
  end

  def sign_out
    cookies.delete(:remember_token)
    self.current_administrator = nil
  end

  def current_administrator=(administrator)
    @current_administrator = administrator
  end

  def current_administrator
    @current_administrator ||= administrator_from_remember_token
  end

  def signed_in?
    !current_administrator.nil?
  end

  def deny_access
    redirect_to signin_path
  end

  private

    def administrator_from_remember_token
      Administrator.authenticate_with_salt(*remember_token)
    end

    def remember_token
      cookies.signed[:remember_token] || [nil, nil]
    end

end

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :set_current_user

  after_filter :set_csrf_cookie_for_ng

  def index
  end

  private

  def set_csrf_cookie_for_ng
    cookies['XSRF-TOKEN'] = form_authenticity_token if protect_against_forgery?
  end


  def verified_request?
    super || form_authenticity_token == request.headers['X-XSRF-TOKEN']
  end

  # Makes the user available in all models, which is pretty handy
  def set_current_user
    User.current = current_user if current_user
  end
end

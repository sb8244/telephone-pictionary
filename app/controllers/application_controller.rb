class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  after_filter :set_csrf_cookie_for_ng

  skip_before_filter :authenticate_user!

  def index
  end

  def authenticate_user!
    return current_user if current_user

    if params[:auth]
      session[:email] = "renee@mannbatz.name"
    elsif session[:email].nil?
      session[:email] = "steve.bussey@sales"
    end

    sign_in(User.find_by(email: session[:email])) if session[:email].present?
  end

  private

  def set_csrf_cookie_for_ng
    cookies['XSRF-TOKEN'] = form_authenticity_token if protect_against_forgery?
  end


  def verified_request?
    super || form_authenticity_token == request.headers['X-XSRF-TOKEN']
  end
end

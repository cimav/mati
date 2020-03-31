require 'google/apis/gmail_v1'
require 'google/api_client/client_secrets'

class ApplicationController < ActionController::Base

  protect_from_forgery unless: -> { request.format.json? }
  skip_before_action :verify_authenticity_token


  def authenticated?
    # URL DE PERMISOS
    # https://myaccount.google.com/u/0/permissions?pli=1
    if !session[:user_email].blank?
      puts "U Auth: #{session[:user_auth]}"
      user = Agent.joins(:person).where(people: { email: session[:user_email], status: Person::STATUS_ACTIVE }).first
      puts "User #{user}"

      session[:user_auth] = user && user.person.email == session[:user_email]
      auth = session[:user_credentials]
      puts auth
      puts "XXXXXXXX"
      user.access_token = auth['token']
      if auth['refresh_token'] != ''
        user.refresh_token = auth['refresh_token']
      end
      user.expires_at = Time.at(auth['expires_at']).to_datetime
      user.save!

      if session[:user_auth]
        session[:agent_id] = user.id
      end
    else
      session[:user_auth]
    end
  end

  helper_method :authenticated?
  helper_method :current_user

  def auth_required
    redirect_to '/login' unless authenticated?
  end

  private
  def current_user
    @current_user ||= Agent.find(session[:agent_id]) if session[:agent_id]
  end
end

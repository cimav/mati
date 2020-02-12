require 'google/apis/gmail_v1'
require 'google/api_client/client_secrets'

class ApplicationController < ActionController::Base

  protect_from_forgery unless: -> { request.format.json? }

  def authenticated?
    if session[:user_auth].blank?

      user = Agent.joins(:person).where(people: { email: session[:user_email], status: Person::STATUS_ACTIVE }).first

      session[:user_auth] = user && user.person.email == session[:user_email]
      auth = session[:user_credentials]
      user.access_token = auth['token']
      user.refresh_token = auth['refresh_token']
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

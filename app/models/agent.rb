require 'net/http'
require 'json'
require 'rmail'

class Agent < ApplicationRecord
  belongs_to :person
  has_many :tickets


  STATUS_ACTIVE = 1
  STATUS_INACTIVE = 2

  AGENT = 1
  ADMIN = 2

  AGENT_TYPES = {
    AGENT => 'Agente',
    ADMIN => 'Administrador'
  }

  STATUS_TEXT = {
    STATUS_ACTIVE => 'Activo',
    STATUS_INACTIVE => 'Inactivo'
  }

  def status_text
    STATUS_TEXT[status]
  end

  def type_text 
    AGENT_TYPES[agent_type]
  end

  def full_name
  	person.full_name
  end

  def email
    person.email
  end


  def picture_url
  	person.picture_url
  end

  def google_api_authorization
    
    self.fresh_token

    secrets = Google::APIClient::ClientSecrets.new(
      {
        "web" =>
          {
            "access_token" => self.access_token,
            "refresh_token" => self.refresh_token,
            "client_id" =>  ENV['GOOGLE_KEY'],
            "client_secret" => ENV['GOOGLE_SECRET']
          }
      }
      )
    secrets.to_authorization 
  end

  def send_mail(to, subject, body)
    service = Google::Apis::GmailV1::GmailService.new
    service.authorization = self.google_api_authorization 

    message = RMail::Message.new
    message.header['To'] = to
    message.header['From'] =  "=?UTF-8?B?" + Base64.strict_encode64("#{self.full_name}") + "?=<#{self.person.email}>"
    message.header['Subject'] = "=?UTF-8?B?" + Base64.strict_encode64(subject) + "?="
    message.header['Content-Type'] = 'text/html; charset=UTF-8'
    message.body = body

    service.send_user_message('me',
                              upload_source: StringIO.new(message.to_s),
                              content_type: 'message/rfc822')
  end

  def request_token_from_google

    params = {'refresh_token' => self.refresh_token,
              'client_id' => ENV['GOOGLE_KEY'],
              'client_secret' => ENV['GOOGLE_SECRET'],
              'grant_type' => 'refresh_token'}

    url = URI("https://accounts.google.com/o/oauth2/token")
    Net::HTTP.post_form(url, params)
  end

  def refresh!
    puts "REFRESH!"
    response = request_token_from_google
    puts response.body
    data = JSON.parse(response.body)
    update_attributes(
    access_token: data['access_token'],
    expires_at: Time.now + (data['expires_in'].to_i).seconds)
  end

  def expired?
    expires_at < Time.now
  end

  def fresh_token
    puts "REFRESH TOKEN"
    if expired?
      puts "EXPIRED TOKEN"
      refresh! 
    end    
  end
end

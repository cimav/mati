Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, ENV['GOOGLE_KEY'], ENV['GOOGLE_SECRET'], {
  	skip_jwt: true,
  	scope: ['email',
    'https://www.googleapis.com/auth/gmail.modify'],
    access_type: 'offline'}
end
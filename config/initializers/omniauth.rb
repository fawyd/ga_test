
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google, GOOGLE_KEY, GOOGLE_SECRET,
    scope: 'https://www.googleapis.com/auth/userinfo.email https://www.googleapis.com/auth/userinfo.profile https://www.google.com/analytics/feeds/'
end

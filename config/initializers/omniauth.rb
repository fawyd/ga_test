
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google, GOOGLE_KEY, GOOGLE_SECRET,
    scope: 'https://www.google.com/analytics/feeds/'
end

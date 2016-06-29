Rails.application.config.middleware.use OmniAuth::Builder do
  provider(
    :auth0,
    'SdG5l9TMqljeFlnkZfI4yuT45rCQFfIk',
    '0BCUYpCqJBtcQZ_wpGP6V_HfP4Is7wj_WHbJYi1GlQdjkMdL7mWs5XWYHbRFa7h3',
    'memtank.eu.auth0.com',
    callback_path: "/auth/auth0/callback"
  )
end

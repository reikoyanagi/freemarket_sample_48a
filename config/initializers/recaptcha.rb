Recaptcha.configure do |config|
  #Google reCAPTCHAのkey
  ENV['RECAPTCHA_SITE_KEY']   = Rails.application.credentials.recaptcha[:site_key]
  ENV['RECAPTCHA_SECRET_KEY'] = Rails.application.credentials.recaptcha[:secret_key]
end

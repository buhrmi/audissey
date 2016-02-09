require 'localeapp/rails'

Localeapp.configure do |config|
  config.api_key = '9T1dZDjcDj7Fvp3v7It5Hz2eLCHGnKp1dWornaz80NyguM99r8'
  config.polling_environments = []
  config.reloading_environments = [:development, :qa, :production]
  config.cache_missing_translations = true
end

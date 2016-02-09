require 'localeapp/rails'

Localeapp.configure do |config|
  config.api_key = '9T1dZDjcDj7Fvp3v7It5Hz2eLCHGnKp1dWornaz80NyguM99r8'
  config.polling_environments = []
  config.reloading_environments = [:development, :qa, :production]
  config.cache_missing_translations = true
  config.translation_data_directory = 'config/locales'
end

#config/initializers/reload_locale.rb
if defined?(ActiveSupport)
  locale_reloader = ActiveSupport::FileUpdateChecker.new(Dir["config/locales/*yml"]) do
     I18n.backend.reload!
  end

  ActionDispatch::Callbacks.to_prepare do
    locale_reloader.execute_if_updated
  end
end

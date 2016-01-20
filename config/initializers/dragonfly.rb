require 'dragonfly'
require 'dragonfly/s3_data_store'

# Configure
Dragonfly.app.configure do
  plugin :imagemagick

  secret ENV['DRAGONFLY_SECRET']

  url_format "/files/:job/:name"

  fetch_file_whitelist [/app\/assets\/images/]
  datastore :s3,
    bucket_name: 'bassmusictokyo',
    access_key_id: ENV['AWS_ACCESS_KEY'],
    secret_access_key: ENV['AWS_SECRET_KEY'],
    region: 'ap-northeast-1' # Tokyo, yay

end


# Logger
Dragonfly.logger = Rails.logger

# Mount as middleware
Rails.application.middleware.use Dragonfly::Middleware

# Add model functionality
if defined?(ActiveRecord::Base)
  ActiveRecord::Base.extend Dragonfly::Model
  ActiveRecord::Base.extend Dragonfly::Model::Validations
end


class ActionView::Helpers::FormBuilder
  def image_upload_field(name)
    @template.render 'uploads/image_field', f: self, name: name
  end
end

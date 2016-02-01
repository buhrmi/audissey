module Translatable
  extend ActiveSupport::Concern

  included do
    has_many :translations
  end

  class_methods do
    def translates field
      define_method "translated_#{field}" do
        Translation.find
      end
    end
  end

end

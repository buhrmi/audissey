module Translatable
  extend ActiveSupport::Concern

  included do
    has_many :translations, :as => 'translatable'
    accepts_nested_attributes_for :translations
  end

  class_methods do
    def accepts_translations_for field
      define_method "#{field}_translations=" do |translation_attributes|
        translations.each do |translation_attributes|

        end
        translations.find_or_create_by_translatable_field_and_locale(field, I18n.locale)
      end

      define_method "translated_#{field}" do

      end
    end
  end

end

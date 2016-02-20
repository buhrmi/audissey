module Translatable
  extend ActiveSupport::Concern

  included do
    has_many :translations, :as => 'translatable'
    # accepts_nested_attributes_for :translations
  end

  class_methods do
    def accepts_translations_for field
      has_many "#{field}_translations".intern, 
        -> { where :translatable_field => field },
        :as => 'translatable'
      accepts_nested_attributes_for "#{field}_translations"
      
      [:en, :ja].each do |locale|
        has_one "#{locale}_#{field}_translation".intern, 
          -> { where :translatable_field => field, :locale => locale },
          :as => 'translatable'
      
        define_method "#{locale}_#{field}" do
          translation = translations.where(:translatable_field => field, :locale => locale).first
          translation&.text || attributes[field.to_s]
        end
        
        define_method "#{locale}_#{field}=" do |val|
          translations.where(:locale => locale, :translatable_field => field).first_or_initialize.update(:text => val)
          
            
          
        end
          
      end
        

      define_method field do
        translation = translations.where(:translatable_field => field, :locale => I18n.locale).first
        translation ||= translations.where(:translatable_field => field).first
        translation&.text || attributes[field.to_s]
      end
      
      define_method "#{field}=" do |val|
        translations.where(:locale => I18n.locale, :translatable_field => field).first_or_initialize.update(:text => val)
        
      end
    end
  end

end

class ActionView::Helpers::FormBuilder
  def translated_text_area(name)
    @template.render 'translations/text_area', f: self, name: name
  end
end

class Purchase < ActiveRecord::Base
  serialize :price_json, JSON
  
end

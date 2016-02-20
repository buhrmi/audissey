json.array!(@brands) do |brand|
  json.extract! brand, :id, :user_id, :name
  json.url brand_url(brand, format: :json)
end

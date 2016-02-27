json.array!(@events) do |event|
  json.extract! event, :id, :brand_id, :venue_id, :flyer_image_uid, :flyer_image_name, :name, :start_at, :end_at
  json.url event_url(event, format: :json)
end

json.array!(@offerings) do |offering|
  json.extract! offering, :id
  json.url offering_url(offering, format: :json)
end

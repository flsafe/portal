json.array!(@opportunities) do |opportunity|
  json.extract! opportunity, :id, :title, :description, :city, :state, :is_open, :is_affilated, : 
  json.url opportunity_url(opportunity, format: :json)
end

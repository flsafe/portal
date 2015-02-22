json.array!(@applications) do |application|
  json.extract! application, :id, :cover_letter, :reviewed, :opportunity_id, :user_id
  json.url application_url(application, format: :json)
end

json.array!(@schools) do |school|
  json.extract! school, :id, :name, :phone, :custom_domain, :website, :address1, :address2, :city, :state, :zip
  json.url school_url(school, format: :json)
end

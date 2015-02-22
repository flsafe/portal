json.array!(@companies) do |company|
  json.extract! company, :id, :name, :description, :website, :address1, :address2, :city, :state, :zip, :phone
  json.url company_url(company, format: :json)
end

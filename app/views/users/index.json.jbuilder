json.array!(@users) do |user|
  json.extract! user, :id, :email, :first_name, :last_name, :bio, :address1, :address2, :role
  json.url user_url(user, format: :json)
end

json.array!(@accounts) do |account|
  json.extract! account, :id, :username, :name, :password, :email, :org, :bio, :location, :website, :profile_img, :header_img
  json.url account_url(account, format: :json)
end

json.array!(@eentries) do |eentry|
  json.extract! eentry, :id, :user_id, :amount, :tags, :details
  json.url eentry_url(eentry, format: :json)
end

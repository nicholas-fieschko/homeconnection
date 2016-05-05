json.array!(@blacklistings) do |blacklisting|
  json.extract! blacklisting, :id, :user_id, :blocked_user
  json.url blacklisting_url(blacklisting, format: :json)
end

json.array!(@exchanges) do |exchange|
  json.extract! exchange, :id, :provider_id, :seeker_id, :s_accepted, :p_accepted, :s_finished, :p_finished
  json.url exchange_url(exchange, format: :json)
end

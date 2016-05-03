json.array!(@reviews) do |review|
  json.extract! review, :id, :public_comments, :private_comments, :rating
  json.url review_url(review, format: :json)
end

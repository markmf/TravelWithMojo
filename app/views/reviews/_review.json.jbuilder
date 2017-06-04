json.extract! review, :id, :user_email, :exp_id, :rating, :rating_desc, :review_date, :created_at, :updated_at
json.url review_url(review, format: :json)

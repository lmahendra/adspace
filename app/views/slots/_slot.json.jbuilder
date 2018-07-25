json.extract! slot, :id, :user_id, :slot_name, :description, :start_time, :end_time, :min_amount, :bid_start, :bid_end, :winner_bid, :status, :created_at, :updated_at
json.url slot_url(slot, format: :json)

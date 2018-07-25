class Bid < ApplicationRecord
	belongs_to :user
	belongs_to :slot
	validate :bid_amount

	def bid_amount
		highest = slot.bids.maximum(:amount) || slot.min_amount
		errors.add(:amount,  " must be greater than last bid") if highest >= amount
	end
end

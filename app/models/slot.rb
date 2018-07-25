class Slot < ApplicationRecord
	has_many :bids
	has_one :winner, :foreign_key => :winner_bid, class_name: "Bid"
	validates_presence_of :allot_days, :slot_name, :start_time, :end_time, :bid_start, :bid_end
	validate :times, :bidding
	after_update :send_mail

	def bidding
		errors.add(:bid_start,  "should after the current time") if bid_start < Time.zone.now.to_date
		errors.add(:bid_end,  "date must be greater than or same as bid start") if bid_start > bid_end
	end

	def times
		dt = Slot.where("slots.id != ?", self.id).where("(TIME(start_time) BETWEEN ? AND ? ) OR (TIME(end_time) BETWEEN ? AND ?)", self.start_time.strftime("%I:%M:00"), self.end_time.strftime("%I:%M:00"), self.start_time.strftime("%I:%M:00"), self.end_time.strftime("%I:%M:00"))
		if self.end_time < self.start_time
		  errors.add(:start_time, "must be less than end time")
		elsif dt.present? 
		  errors.add(:start_time, ": Times overlap another slot")
		end
	end

	def send_mail
		if self.status == 2
			SlotMailer.slot_allotted(self, Bid.find(winner_bid).user).deliver_now
		end
	end

	def can_bid
		today = Time.zone.now.to_date
		bid_start <= today && bid_end >= today
	end

	def self.available
		today = Time.zone.now.to_date
		where("winner_bid is null AND (DATE(bid_start) <= ? AND DATE(bid_end) >= ?)", today, today)
	end

	def can_bid_user(user)
		!(bids.last.try(:user_id) == user.id)
	end

	def status_text
		if status == 1 && bid_end >= Time.zone.now.to_date
			return "Available"
		elsif status == 1 && bid_end < Time.zone.now.to_date
			return "Unallotted"
		elsif status == 2 && expiry >= Time.zone.now.to_date
			return "Allotted"
		else 
			return "Expired"
		end				
	end

	def last_bid
		bids.last
	end

	def allot
		highest = self.bids.order("amount desc").first
		self.winner_bid = highest.try(:id)
		self.status = 2
		self.expiry = Time.zone.now.to_date + self.allot_days.to_i.days
		self.save(validate: false) if highest.present?
	end
end

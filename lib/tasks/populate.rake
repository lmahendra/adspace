namespace :slots do
  task :allot => :environment do
	Slot.where(bid_end: Time.zone.now.to_date).each do |slot|
		slot.allot
	end
  end
end
class SlotMailer < ApplicationMailer
  def slot_allotted(slot, user)
  	@slot = slot
  	@user = user
  	mail(to: @user.try(:email), subject: "Congratulations! Ad slot is allotted to you")
  end
end
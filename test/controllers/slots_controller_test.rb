require 'test_helper'

class SlotsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @slot = slots(:one)
  end

  test "should get index" do
    get slots_url
    assert_response :success
  end

  test "should get new" do
    get new_slot_url
    assert_response :success
  end

  test "should create slot" do
    assert_difference('Slot.count') do
      post slots_url, params: { slot: { bid_end: @slot.bid_end, bid_start: @slot.bid_start, description: @slot.description, end_time: @slot.end_time, min_amount: @slot.min_amount, slot_name: @slot.slot_name, start_time: @slot.start_time, status: @slot.status, user_id: @slot.user_id, winner_bid: @slot.winner_bid } }
    end

    assert_redirected_to slot_url(Slot.last)
  end

  test "should show slot" do
    get slot_url(@slot)
    assert_response :success
  end

  test "should get edit" do
    get edit_slot_url(@slot)
    assert_response :success
  end

  test "should update slot" do
    patch slot_url(@slot), params: { slot: { bid_end: @slot.bid_end, bid_start: @slot.bid_start, description: @slot.description, end_time: @slot.end_time, min_amount: @slot.min_amount, slot_name: @slot.slot_name, start_time: @slot.start_time, status: @slot.status, user_id: @slot.user_id, winner_bid: @slot.winner_bid } }
    assert_redirected_to slot_url(@slot)
  end

  test "should destroy slot" do
    assert_difference('Slot.count', -1) do
      delete slot_url(@slot)
    end

    assert_redirected_to slots_url
  end
end

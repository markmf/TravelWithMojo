require 'test_helper'

class ExperiencesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @experience = experiences(:one)
  end

  test "should get index" do
    get experiences_url
    assert_response :success
  end

  test "should get new" do
    get new_experience_url
    assert_response :success
  end

  test "should create experience" do
    assert_difference('Experience.count') do
      post experiences_url, params: { experience: { about_me: @experience.about_me, can_policy: @experience.can_policy, duration: @experience.duration, exp_desc: @experience.exp_desc, exp_email: @experience.exp_email, exp_id: @experience.exp_id, exp_location: @experience.exp_location, exp_name: @experience.exp_name, exp_notes: @experience.exp_notes, exp_price: @experience.exp_price, exp_provide: @experience.exp_provide, guest_reqs: @experience.guest_reqs, image_file_name: @experience.image_file_name, integer: @experience.integer, max_guest: @experience.max_guest, min_guest: @experience.min_guest, ratings: @experience.ratings, rsv_guest: @experience.rsv_guest, start_time: @experience.start_time } }
    end

    assert_redirected_to experience_url(Experience.last)
  end

  test "should show experience" do
    get experience_url(@experience)
    assert_response :success
  end

  test "should get edit" do
    get edit_experience_url(@experience)
    assert_response :success
  end

  test "should update experience" do
    patch experience_url(@experience), params: { experience: { about_me: @experience.about_me, can_policy: @experience.can_policy, duration: @experience.duration, exp_desc: @experience.exp_desc, exp_email: @experience.exp_email, exp_id: @experience.exp_id, exp_location: @experience.exp_location, exp_name: @experience.exp_name, exp_notes: @experience.exp_notes, exp_price: @experience.exp_price, exp_provide: @experience.exp_provide, guest_reqs: @experience.guest_reqs, image_file_name: @experience.image_file_name, integer: @experience.integer, max_guest: @experience.max_guest, min_guest: @experience.min_guest, ratings: @experience.ratings, rsv_guest: @experience.rsv_guest, start_time: @experience.start_time } }
    assert_redirected_to experience_url(@experience)
  end

  test "should destroy experience" do
    assert_difference('Experience.count', -1) do
      delete experience_url(@experience)
    end

    assert_redirected_to experiences_url
  end
end

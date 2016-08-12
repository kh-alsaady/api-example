require 'test_helper'

class Api::V1::TwilioExamplesControllerTest < ActionController::TestCase
  test "should get send_sms" do
    get :send_sms
    assert_response :success
  end

  test "should get receive_sms" do
    get :receive_sms
    assert_response :success
  end

end

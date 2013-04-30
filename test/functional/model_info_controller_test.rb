require 'test_helper'

class ModelInfoControllerTest < ActionController::TestCase
  test "should get DBNotes" do
    get :DBNotes
    assert_response :success
  end

end

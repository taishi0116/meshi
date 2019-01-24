require 'test_helper'

class CreatedControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get created_index_url
    assert_response :success
  end

end

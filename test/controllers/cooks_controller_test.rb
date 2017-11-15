require 'test_helper'

class CooksControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get cooks_index_url
    assert_response :success
  end

end

require 'test_helper'

class EventCollectionsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get event_collections_index_url
    assert_response :success
  end

end

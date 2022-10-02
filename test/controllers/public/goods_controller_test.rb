require "test_helper"

class Public::GoodsControllerTest < ActionDispatch::IntegrationTest
  test "should get search" do
    get public_goods_search_url
    assert_response :success
  end
end

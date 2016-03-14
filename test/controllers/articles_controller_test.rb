require 'test_helper'

class ArticlesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get createdestroy" do
    get :createdestroy
    assert_response :success
  end

  test "should get pinned" do
    get :pinned
    assert_response :success
  end

end

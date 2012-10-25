require 'test_helper'

class StaticPagesControllerTest < ActionController::TestCase
  test "should get home" do
    get :home
    assert_response :success
  end

  test "should get scrapbook" do
    get :scrapbook
    assert_response :success
  end

  test "should get profile" do
    get :profile
    assert_response :success
  end

  test "should get about" do
    get :about
    assert_response :success
  end

end

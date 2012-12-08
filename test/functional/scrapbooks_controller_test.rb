require 'test_helper'

class ScrapbooksControllerTest < ActionController::TestCase
  setup do
    @scrapbook = scrapbooks(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:scrapbooks)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create scrapbook" do
    assert_difference('Scrapbook.count') do
      post :create, scrapbook: { period: @scrapbook.period }
    end

    assert_redirected_to scrapbook_path(assigns(:scrapbook))
  end

  test "should show scrapbook" do
    get :show, id: @scrapbook
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @scrapbook
    assert_response :success
  end

  test "should update scrapbook" do
    put :update, id: @scrapbook, scrapbook: { period: @scrapbook.period }
    assert_redirected_to scrapbook_path(assigns(:scrapbook))
  end

  test "should destroy scrapbook" do
    assert_difference('Scrapbook.count', -1) do
      delete :destroy, id: @scrapbook
    end

    assert_redirected_to scrapbooks_path
  end
end

require 'test_helper'

class ScrapImagesControllerTest < ActionController::TestCase
  setup do
    @scrap_image = scrap_images(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:scrap_images)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create scrap_image" do
    assert_difference('ScrapImage.count') do
      post :create, scrap_image: { content: @scrap_image.content, date: @scrap_image.date, image_url: @scrap_image.image_url, month: @scrap_image.month, title: @scrap_image.title, user_id: @scrap_image.user_id, week: @scrap_image.week, year: @scrap_image.year }
    end

    assert_redirected_to scrap_image_path(assigns(:scrap_image))
  end

  test "should show scrap_image" do
    get :show, id: @scrap_image
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @scrap_image
    assert_response :success
  end

  test "should update scrap_image" do
    put :update, id: @scrap_image, scrap_image: { content: @scrap_image.content, date: @scrap_image.date, image_url: @scrap_image.image_url, month: @scrap_image.month, title: @scrap_image.title, user_id: @scrap_image.user_id, week: @scrap_image.week, year: @scrap_image.year }
    assert_redirected_to scrap_image_path(assigns(:scrap_image))
  end

  test "should destroy scrap_image" do
    assert_difference('ScrapImage.count', -1) do
      delete :destroy, id: @scrap_image
    end

    assert_redirected_to scrap_images_path
  end
end

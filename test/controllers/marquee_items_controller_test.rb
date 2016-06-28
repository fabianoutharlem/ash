require 'test_helper'

class MarqueeItemsControllerTest < ActionController::TestCase
  setup do
    @marquee_item = marquee_items(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:marquee_items)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create marquee_item" do
    assert_difference('MarqueeItem.count') do
      post :create, marquee_item: { link: @marquee_item.link, title: @marquee_item.title }
    end

    assert_redirected_to marquee_item_path(assigns(:marquee_item))
  end

  test "should show marquee_item" do
    get :show, id: @marquee_item
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @marquee_item
    assert_response :success
  end

  test "should update marquee_item" do
    patch :update, id: @marquee_item, marquee_item: { link: @marquee_item.link, title: @marquee_item.title }
    assert_redirected_to marquee_item_path(assigns(:marquee_item))
  end

  test "should destroy marquee_item" do
    assert_difference('MarqueeItem.count', -1) do
      delete :destroy, id: @marquee_item
    end

    assert_redirected_to marquee_items_path
  end
end

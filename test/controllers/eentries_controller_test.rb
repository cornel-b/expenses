require 'test_helper'

class EentriesControllerTest < ActionController::TestCase
  setup do
    @eentry = eentries(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:eentries)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create eentry" do
    assert_difference('Eentry.count') do
      post :create, eentry: { amount: @eentry.amount, details: @eentry.details, tags: @eentry.tags, user_id: @eentry.user_id }
    end

    assert_redirected_to eentry_path(assigns(:eentry))
  end

  test "should show eentry" do
    get :show, id: @eentry
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @eentry
    assert_response :success
  end

  test "should update eentry" do
    patch :update, id: @eentry, eentry: { amount: @eentry.amount, details: @eentry.details, tags: @eentry.tags, user_id: @eentry.user_id }
    assert_redirected_to eentry_path(assigns(:eentry))
  end

  test "should destroy eentry" do
    assert_difference('Eentry.count', -1) do
      delete :destroy, id: @eentry
    end

    assert_redirected_to eentries_path
  end
end

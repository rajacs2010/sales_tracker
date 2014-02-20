require 'test_helper'

class KdDetailsControllerTest < ActionController::TestCase
  setup do
    @kd_detail = kd_details(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:kd_details)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create kd_detail" do
    assert_difference('KdDetail.count') do
      post :create, kd_detail: {  }
    end

    assert_redirected_to kd_detail_path(assigns(:kd_detail))
  end

  test "should show kd_detail" do
    get :show, id: @kd_detail
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @kd_detail
    assert_response :success
  end

  test "should update kd_detail" do
    put :update, id: @kd_detail, kd_detail: {  }
    assert_redirected_to kd_detail_path(assigns(:kd_detail))
  end

  test "should destroy kd_detail" do
    assert_difference('KdDetail.count', -1) do
      delete :destroy, id: @kd_detail
    end

    assert_redirected_to kd_details_path
  end
end

require 'test_helper'

class ActualRoutesControllerTest < ActionController::TestCase
  setup do
    @actual_route = actual_routes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:actual_routes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create actual_route" do
    assert_difference('ActualRoute.count') do
      post :create, actual_route: {  }
    end

    assert_redirected_to actual_route_path(assigns(:actual_route))
  end

  test "should show actual_route" do
    get :show, id: @actual_route
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @actual_route
    assert_response :success
  end

  test "should update actual_route" do
    put :update, id: @actual_route, actual_route: {  }
    assert_redirected_to actual_route_path(assigns(:actual_route))
  end

  test "should destroy actual_route" do
    assert_difference('ActualRoute.count', -1) do
      delete :destroy, id: @actual_route
    end

    assert_redirected_to actual_routes_path
  end
end

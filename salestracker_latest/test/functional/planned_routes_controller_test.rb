require 'test_helper'

class PlannedRoutesControllerTest < ActionController::TestCase
  setup do
    @planned_route = planned_routes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:planned_routes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create planned_route" do
    assert_difference('PlannedRoute.count') do
      post :create, planned_route: {  }
    end

    assert_redirected_to planned_route_path(assigns(:planned_route))
  end

  test "should show planned_route" do
    get :show, id: @planned_route
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @planned_route
    assert_response :success
  end

  test "should update planned_route" do
    put :update, id: @planned_route, planned_route: {  }
    assert_redirected_to planned_route_path(assigns(:planned_route))
  end

  test "should destroy planned_route" do
    assert_difference('PlannedRoute.count', -1) do
      delete :destroy, id: @planned_route
    end

    assert_redirected_to planned_routes_path
  end
end

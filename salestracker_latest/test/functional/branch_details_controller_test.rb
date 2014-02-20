require 'test_helper'

class BranchDetailsControllerTest < ActionController::TestCase
  setup do
    @branch_detail = branch_details(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:branch_details)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create branch_detail" do
    assert_difference('BranchDetail.count') do
      post :create, branch_detail: {  }
    end

    assert_redirected_to branch_detail_path(assigns(:branch_detail))
  end

  test "should show branch_detail" do
    get :show, id: @branch_detail
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @branch_detail
    assert_response :success
  end

  test "should update branch_detail" do
    put :update, id: @branch_detail, branch_detail: {  }
    assert_redirected_to branch_detail_path(assigns(:branch_detail))
  end

  test "should destroy branch_detail" do
    assert_difference('BranchDetail.count', -1) do
      delete :destroy, id: @branch_detail
    end

    assert_redirected_to branch_details_path
  end
end

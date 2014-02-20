require 'test_helper'

class TempEmpTreesControllerTest < ActionController::TestCase
  setup do
    @temp_emp_tree = temp_emp_trees(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:temp_emp_trees)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create temp_emp_tree" do
    assert_difference('TempEmpTree.count') do
      post :create, temp_emp_tree: {  }
    end

    assert_redirected_to temp_emp_tree_path(assigns(:temp_emp_tree))
  end

  test "should show temp_emp_tree" do
    get :show, id: @temp_emp_tree
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @temp_emp_tree
    assert_response :success
  end

  test "should update temp_emp_tree" do
    put :update, id: @temp_emp_tree, temp_emp_tree: {  }
    assert_redirected_to temp_emp_tree_path(assigns(:temp_emp_tree))
  end

  test "should destroy temp_emp_tree" do
    assert_difference('TempEmpTree.count', -1) do
      delete :destroy, id: @temp_emp_tree
    end

    assert_redirected_to temp_emp_trees_path
  end
end

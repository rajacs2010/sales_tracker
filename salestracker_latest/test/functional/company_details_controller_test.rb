require 'test_helper'

class CompanyDetailsControllerTest < ActionController::TestCase
  setup do
    @company_detail = company_details(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:company_details)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create company_detail" do
    assert_difference('CompanyDetail.count') do
      post :create, company_detail: {  }
    end

    assert_redirected_to company_detail_path(assigns(:company_detail))
  end

  test "should show company_detail" do
    get :show, id: @company_detail
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @company_detail
    assert_response :success
  end

  test "should update company_detail" do
    put :update, id: @company_detail, company_detail: {  }
    assert_redirected_to company_detail_path(assigns(:company_detail))
  end

  test "should destroy company_detail" do
    assert_difference('CompanyDetail.count', -1) do
      delete :destroy, id: @company_detail
    end

    assert_redirected_to company_details_path
  end
end

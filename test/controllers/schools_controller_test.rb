require 'test_helper'

class SchoolsControllerTest < ActionController::TestCase
  setup do
    @school = schools(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:schools)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create school" do
    assert_difference('School.count') do
      post :create, school: { address1: @school.address1, address2: @school.address2, city: @school.city, custom_domain: @school.custom_domain, name: @school.name, phone: @school.phone, state: @school.state, website: @school.website, zip: @school.zip }
    end

    assert_redirected_to school_path(assigns(:school))
  end

  test "should show school" do
    get :show, id: @school
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @school
    assert_response :success
  end

  test "should update school" do
    patch :update, id: @school, school: { address1: @school.address1, address2: @school.address2, city: @school.city, custom_domain: @school.custom_domain, name: @school.name, phone: @school.phone, state: @school.state, website: @school.website, zip: @school.zip }
    assert_redirected_to school_path(assigns(:school))
  end

  test "should destroy school" do
    assert_difference('School.count', -1) do
      delete :destroy, id: @school
    end

    assert_redirected_to schools_path
  end
end

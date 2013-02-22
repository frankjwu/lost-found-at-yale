require 'test_helper'

class FoundsControllerTest < ActionController::TestCase
  setup do
    @found = founds(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:founds)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create found" do
    assert_difference('Found.count') do
      post :create, found: { date: @found.date, desc: @found.desc, location: @found.location }
    end

    assert_redirected_to found_path(assigns(:found))
  end

  test "should show found" do
    get :show, id: @found
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @found
    assert_response :success
  end

  test "should update found" do
    put :update, id: @found, found: { date: @found.date, desc: @found.desc, location: @found.location }
    assert_redirected_to found_path(assigns(:found))
  end

  test "should destroy found" do
    assert_difference('Found.count', -1) do
      delete :destroy, id: @found
    end

    assert_redirected_to founds_path
  end
end

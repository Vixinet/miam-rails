require 'test_helper'

class Admin::ProductGroupsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin_product_group = admin_product_groups(:one)
  end

  test "should get index" do
    get admin_product_groups_url
    assert_response :success
  end

  test "should get new" do
    get new_admin_product_group_url
    assert_response :success
  end

  test "should create admin_product_group" do
    assert_difference('Admin::ProductGroup.count') do
      post admin_product_groups_url, params: { admin_product_group: { description: @admin_product_group.description, label: @admin_product_group.label, venue_id: @admin_product_group.venue_id } }
    end

    assert_redirected_to admin_product_group_url(Admin::ProductGroup.last)
  end

  test "should show admin_product_group" do
    get admin_product_group_url(@admin_product_group)
    assert_response :success
  end

  test "should get edit" do
    get edit_admin_product_group_url(@admin_product_group)
    assert_response :success
  end

  test "should update admin_product_group" do
    patch admin_product_group_url(@admin_product_group), params: { admin_product_group: { description: @admin_product_group.description, label: @admin_product_group.label, venue_id: @admin_product_group.venue_id } }
    assert_redirected_to admin_product_group_url(@admin_product_group)
  end

  test "should destroy admin_product_group" do
    assert_difference('Admin::ProductGroup.count', -1) do
      delete admin_product_group_url(@admin_product_group)
    end

    assert_redirected_to admin_product_groups_url
  end
end

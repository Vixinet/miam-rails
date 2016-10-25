require 'test_helper'

class Admin::ProductVariationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin_product_variation = admin_product_variations(:one)
  end

  test "should get index" do
    get admin_product_variations_url
    assert_response :success
  end

  test "should get new" do
    get new_admin_product_variation_url
    assert_response :success
  end

  test "should create admin_product_variation" do
    assert_difference('Admin::ProductVariation.count') do
      post admin_product_variations_url, params: { admin_product_variation: { allow_multi_choices: @admin_product_variation.allow_multi_choices, label: @admin_product_variation.label, product_id: @admin_product_variation.product_id } }
    end

    assert_redirected_to admin_product_variation_url(Admin::ProductVariation.last)
  end

  test "should show admin_product_variation" do
    get admin_product_variation_url(@admin_product_variation)
    assert_response :success
  end

  test "should get edit" do
    get edit_admin_product_variation_url(@admin_product_variation)
    assert_response :success
  end

  test "should update admin_product_variation" do
    patch admin_product_variation_url(@admin_product_variation), params: { admin_product_variation: { allow_multi_choices: @admin_product_variation.allow_multi_choices, label: @admin_product_variation.label, product_id: @admin_product_variation.product_id } }
    assert_redirected_to admin_product_variation_url(@admin_product_variation)
  end

  test "should destroy admin_product_variation" do
    assert_difference('Admin::ProductVariation.count', -1) do
      delete admin_product_variation_url(@admin_product_variation)
    end

    assert_redirected_to admin_product_variations_url
  end
end

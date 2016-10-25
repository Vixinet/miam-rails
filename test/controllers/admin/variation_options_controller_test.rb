require 'test_helper'

class Admin::VariationOptionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin_variation_option = admin_variation_options(:one)
  end

  test "should get index" do
    get admin_variation_options_url
    assert_response :success
  end

  test "should get new" do
    get new_admin_variation_option_url
    assert_response :success
  end

  test "should create admin_variation_option" do
    assert_difference('Admin::VariationOption.count') do
      post admin_variation_options_url, params: { admin_variation_option: { allow_multi_choices: @admin_variation_option.allow_multi_choices, label: @admin_variation_option.label, product_variation_id: @admin_variation_option.product_variation_id } }
    end

    assert_redirected_to admin_variation_option_url(Admin::VariationOption.last)
  end

  test "should show admin_variation_option" do
    get admin_variation_option_url(@admin_variation_option)
    assert_response :success
  end

  test "should get edit" do
    get edit_admin_variation_option_url(@admin_variation_option)
    assert_response :success
  end

  test "should update admin_variation_option" do
    patch admin_variation_option_url(@admin_variation_option), params: { admin_variation_option: { allow_multi_choices: @admin_variation_option.allow_multi_choices, label: @admin_variation_option.label, product_variation_id: @admin_variation_option.product_variation_id } }
    assert_redirected_to admin_variation_option_url(@admin_variation_option)
  end

  test "should destroy admin_variation_option" do
    assert_difference('Admin::VariationOption.count', -1) do
      delete admin_variation_option_url(@admin_variation_option)
    end

    assert_redirected_to admin_variation_options_url
  end
end

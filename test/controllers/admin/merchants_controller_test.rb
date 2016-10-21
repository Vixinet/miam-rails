require 'test_helper'

class Admin::MerchantsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin_merchant = admin_merchants(:one)
  end

  test "should get index" do
    get admin_merchants_url
    assert_response :success
  end

  test "should get new" do
    get new_admin_merchant_url
    assert_response :success
  end

  test "should create admin_merchant" do
    assert_difference('Admin::Merchant.count') do
      post admin_merchants_url, params: { admin_merchant: {  } }
    end

    assert_redirected_to admin_merchant_url(Admin::Merchant.last)
  end

  test "should show admin_merchant" do
    get admin_merchant_url(@admin_merchant)
    assert_response :success
  end

  test "should get edit" do
    get edit_admin_merchant_url(@admin_merchant)
    assert_response :success
  end

  test "should update admin_merchant" do
    patch admin_merchant_url(@admin_merchant), params: { admin_merchant: {  } }
    assert_redirected_to admin_merchant_url(@admin_merchant)
  end

  test "should destroy admin_merchant" do
    assert_difference('Admin::Merchant.count', -1) do
      delete admin_merchant_url(@admin_merchant)
    end

    assert_redirected_to admin_merchants_url
  end
end

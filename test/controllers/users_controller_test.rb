require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = build(:user)
    @headers = invalid_headers.except("Authorization")
    @valid_attributes = attributes_for(:user, password_confirmation: @user.password)
  end

  test "POST /signup with valid request should create a new user" do
    post signup_url, params: @valid_attributes, headers: @headers, as: :json

    assert_response :created
    assert_equal 'Account created successfully', json['message']
    refute_nil json['auth_token']
  end

  test "POST /signup with invalid request should not create a new user" do
    post signup_url, params: {}, headers: @headers, as: :json

    assert_response :unprocessable_entity
    assert_equal "Validation failed: Password can't be blank, Name can't be blank, Email can't be blank, Password digest can't be blank", json['message']
    assert_nil json['auth_token']
  end
end

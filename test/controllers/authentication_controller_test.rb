require 'test_helper'

class AuthenticationControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = create(:user)
    @headers = valid_headers(@user.id).except("Authorization")
    @valid_credentials = { email: @user.email, password: @user.password }
    @invalid_credentials = { email: Faker::Internet.email, password: Faker::Internet.password }
  end

  test "when request is valid it returns an authentication token" do
    post auth_login_url, params: @valid_credentials, headers: @headers, as: :json
    assert_response :success
  end
  test "when request is invalid it returns a failure message" do
    post auth_login_url, params: @invalid_credentials, headers: @headers, as: :json
    assert_response :unauthorized
    assert_equal "Invalid credentials", json['message']
  end
end

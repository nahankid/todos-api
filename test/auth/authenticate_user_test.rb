require 'test_helper'

class AuthenticateUserTest < ActiveSupport::TestCase
  def setup
    @user = create(:user)
    @valid_auth_obj = AuthenticateUser.new(@user.email, @user.password)
    @invalid_auth_obj = AuthenticateUser.new('foo', 'bar')
  end

  test "valid credentials return an auth token" do
    token = @valid_auth_obj.call
    refute_nil token
  end

  test "invalid credentials raise an authentication error" do
    assert_raises ExceptionHandler::AuthenticationError do
      @invalid_auth_obj.call
    end
  end
end

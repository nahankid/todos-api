require 'test_helper'

class AuthorizeApiRequestTest < ActiveSupport::TestCase
  def setup
    @user = create(:user)
    @header = { 'Authorization' => token_generator(@user.id) }
    @invalid_request_obj = AuthorizeApiRequest.new({})
    @request_obj = AuthorizeApiRequest.new(@header)
  end

  test "valid request object returns valid user object" do
    result = @request_obj.call
    assert_equal result[:user], @user
  end

  test "request with missing token raises MissingToken error" do
    assert_raises ExceptionHandler::MissingToken do
      @invalid_request_obj.call
    end
  end

  test "request with invalid token raises InvalidToken error" do
    assert_raises ExceptionHandler::InvalidToken do
      AuthorizeApiRequest.new('Authorization' => token_generator(5)).call
    end
  end

  test "request with expired token raises ExpiredSignature error" do
    assert_raises ExceptionHandler::ExpiredSignature do
      AuthorizeApiRequest.new('Authorization' => expired_token_generator(@user.id)).call
    end
  end
end

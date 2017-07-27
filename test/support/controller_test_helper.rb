module ControllerTestHelper
  # generate tokens from user id
  def token_generator(user_id)
    JsonWebToken.encode(user_id: user_id)
  end

  # generate expired tokens from user id
  def expired_token_generator(user_id)
    JsonWebToken.encode({ user_id: user_id }, (Time.now.to_i - 10))
  end

  # return valid headers
  def valid_headers(user_id)
    {
      "Authorization" => token_generator(user_id),
      "Content-Type" => 'application/vnd.api+json'
    }
  end

  # return invalid headers
  def invalid_headers
    {
      "Authorization" => nil,
      "Content-Type" => content_type
    }
  end

  def json
    JSON.parse(response.body)
  end

  def content_type
    'application/vnd.api+json'
  end
end

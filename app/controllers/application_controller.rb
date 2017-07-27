class ApplicationController < ActionController::API
  include ExceptionHandler

  # called before every action on controllers
  before_action :check_header
  before_action :authorize_request

  attr_reader :current_user

  private

  def check_header
    if ['POST','PUT','PATCH'].include? request.method
      if request.content_type != "application/vnd.api+json"
        head 406 and return
      end
    end
  end

  # # Check for valid request token and return user
  def authorize_request
    @current_user = (AuthorizeApiRequest.new(request.headers).call)[:user]
  end
end

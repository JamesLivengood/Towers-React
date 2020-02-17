class ApplicationController < ActionController::Base
  # protect_from_forgery with: :null_session
  rescue_from StandardError, with: :return_error_response

  def return_error_response(error)
    render json: { error: error.inspect }, status: 500
  end 
end

class Api::V1::BaseController < ApplicationController
  # to use authenticate_or_request_with_http_token method
  include ActionController::HttpAuthentication::Token::ControllerMethods

  # Add below line to make AWS work with rails-api
  #include ActionController::Serialization
  before_action :authenticate

  # Private methods
  private

  # use rails built in authentication
  # def authenticate
  # 	authenticate_or_request_with_http_token  do |token, options|
  # 		@user = User.find_by_authentication_token token
  # 	end
  # end

  # doing authentication manually
  def authenticate
  	# get token from header
  	authentication_token = request.headers['token']
  	@user = User.find_by_authentication_token authentication_token if authentication_token

  	unless @user
  		render json: {success: false, message: I18n.t('unauthorized'), data: {}}, status: :unauthorized
  		return false
  	end
  end


end

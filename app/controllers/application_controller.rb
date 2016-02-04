class ApplicationController < ActionController::API
  # ParamError is superclass of ParamMissing, ParamInvalid
  rescue_from Apipie::ParamError do |e|
  	render json: { success: false, message: e.message, data: {} }, status: 400
  end
  
  
end

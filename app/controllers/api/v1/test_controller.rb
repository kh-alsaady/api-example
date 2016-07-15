class Api::V1::TestController < Api::V1::BaseController
  skip_before_action :authenticate
  include ActionView::Helpers

  include VehicleBoundriesHelper

  def index
    respond_to do |f|
      f.js
    end
  end

  api 'GET', '/test/check_vehicle_boundary', 'Check car boundries'

  param :vehicle_lat,  Float, desc: 'Current vehicle latitude',  required: true
	param :vehicle_long, Float, desc: 'Current vehicle longitude', required: true
  # only for circle boundries
  def check_vehicle_boundary
			centeral_lat   = 30.705083
			centeral_long  = 76.692193
      # Allowed distance in kilometer
			allowed_distance = 10

			vehicle_lat    = params[:vehicle_lat].to_f
			vehicle_long   = params[:vehicle_long].to_f
			# vehicle_lat    = 30.719564
			# vehicle_long   = 76.690664


			result = haversine(centeral_lat, centeral_long, vehicle_lat, vehicle_long)

			if result > allowed_distance
				render json: {success: true, message: 'The vehicle now outside the boundaries', data: {distance: result, time: DateTime.now.strftime("%Y/%m/%d at %H:%M")}}, status: 200
			else
				render json: {success: true, message: 'The vehicle now inside the boundaries', data: {distance: result}}, status: 200
			end
	end

  def for_test
    # respond_to do |f|
    #   f.js
    # end
      render json: {data: content_tag('div', 'hello') }
  end

  private
	# calculate the distance between two point using haversine formula
  def haversine(lat1, long1, lat2, long2)
	  dtor = Math::PI/180
	  #for kilometer
	  r = 6378.14
	  # For Mile
	  # r = 3959
	  # For meter r = 6378.14*1000
	  rlat1 = lat1 * dtor
	  rlong1 = long1 * dtor
	  rlat2 = lat2 * dtor
	  rlong2 = long2 * dtor

	  dlon = rlong1 - rlong2
	  dlat = rlat1 - rlat2

	  a = power(Math::sin(dlat/2), 2) + Math::cos(rlat1) * Math::cos(rlat2) * power(Math::sin(dlon/2), 2)
	  c = 2 * Math::atan2(Math::sqrt(a), Math::sqrt(1-a))
	  d = r * c

	  return d
  end

  def power(num, pow)
		num ** pow
  end

end

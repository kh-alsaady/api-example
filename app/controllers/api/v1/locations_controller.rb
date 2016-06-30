class Api::V1::LocationsController < Api::V1::BaseController

	skip_before_action :authenticate
	before_action :location_details


	resource_description do 		
		short 'APIs for google apis result'
	end

	api :GET, '/v1/location/long_lat', 'Get location details from google api'
		param :latitude,  Float,        'latitude of the location',  required: true
		param :longitude, Float,        'longitude of the location', required: true
		param :lang_code, ['en', 'ar'], 'Select language',    required: true

	def long_lat
		latitude  = params[:latitude]
		longitude = params[:longitude]
		lang_code = params[:language]

		uri = URI("https://maps.googleapis.com/maps/api/geocode/json?latlng=#{latitude},#{longitude}&language=#{lang_code}&key=AIzaSyBIeKA2StSYW1Mact1_T35pO_iP3KvkMX8")	  	
		data = JSON.parse(Net::HTTP.get_response(uri).body)
		
		if data['status'] == 'OK'	
			get_location_details data		
			render json: { success: true, message: 'Data found', data: @location_details}, status: 200	
		else
			render json: { success: false, message: 'No data found', data: {}}, status: 400
		end			
	end	  	

	api :GET, '/v1/location/details', 'Get location details from google api'
		param :location,  String, 'location name',  required: true
		
	def details
		location  = params[:location]

		uri = URI(URI.encode("https://maps.googleapis.com/maps/api/geocode/json?address=#{location}&key=AIzaSyBIeKA2StSYW1Mact1_T35pO_iP3KvkMX8"))
		data = JSON.parse(Net::HTTP.get_response(uri).body)

		if data['status'] == 'OK'
			get_location_details data		
			render json: { success: true, message: 'Data found', data: @location_details}, status: 200	
		else
			render json: { success: false, message: 'No data found', data: {}}, status: 400
		end			
	end	 

	api :GET, '/v1/location/test', 'Get location details from google api'
		param :latitude,  Float,        'latitude of the location',  required: true
		param :longitude, Float,        'longitude of the location', required: true
		param :radius,    Float,        'radius in km',              required: true
		param :lang_code, ['en', 'ar'], 'Select language',    required: true
	def boundries

	end

	private 	
	
	def location_details
		@location_details = { route: 'streat', locality: 'city', country: 'country', postal_code: 'postal_code', 
			                 location: { lng: '', lat: '' } }

		@location_details_keys = @location_details.keys
	end

	def get_location_details data
		address_components = data["results"].first['address_components']
			location           = data['results'].first['geometry']['location']   

			@location_details_keys.each do |key|
				address_components.each do |address|
					@location_details[key] = address['long_name']  if key.to_s == address['types'].first
				end
			end

			@location_details[:location] = location	
	end			
end

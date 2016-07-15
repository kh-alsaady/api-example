class Api::V1::CloudinaryController < Api::V1::BaseController

  skip_before_action :authenticate
  resource_description do
	short "API's for Upload Files to cloudinary cloud"
  end

  api 'POST', "/v1/cloudinary/upload", 'Upload file to cloudinary'
  param :file, ActionDispatch::Http::UploadedFile, desc: 'The file you want too upload', required: true
  def upload
  	# result = Cloudinary::Api.ping

  	result = Cloudinary::Uploader.upload(params[:file], resource_type: :auto, use_filename: true)
  	# result = Cloudinary::Uploader.rename('alvuxpzcxpzk4rq4oy8j', 'khalid')
  	render json: {success: true, message: "The file uploaded successfull", data: result }, status: 200
  end

  # Cloudinary::Uploader.rename('old_public_id', 'new_public_id')
  # Cloudinary::Uploader.destroy('public_id')
  # Return all the resources stored in cloudinary
  #result = Cloudinary::Api.resources

end

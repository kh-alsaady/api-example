Apipie.configure do |config|
  config.app_name                = "ApiExample"
  config.api_base_url            = "/api"
  config.doc_base_url            = "/apipie"
  config.validate                = true
  config.validate_value          = true
  # where is your API defined?
  config.api_controllers_matcher = "#{Rails.root}/app/controllers/**/*.rb"
  config.reload_controllers = true
end

# Override Apipie invalid parameter return message
Apipie::ParamInvalid.class_eval do
  def to_s
	#"Invalid parameter '#{@param}' value #{@value.inspect}: #{@error}"
	"#{@param} #{@error}"
  end
end


# Override Apipie invalid parameter return message
Apipie::ParamMissing.class_eval do
  def to_s
	"Missing parameter #{@param}"
  end
end
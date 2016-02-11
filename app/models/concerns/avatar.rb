module Avatar

	extend ActiveSupport::Concern
	
	included do 
		# common features between models and override class methods can be written here
		# for paperclip support
  		has_attached_file :avatar, styles: {small: '100x100', medium: '200x200'}, default_url: "/images/:style/missing.png" 
	end

	# Instance methods written here

	# class methods written here
	module ClassMethods

	end
	
end
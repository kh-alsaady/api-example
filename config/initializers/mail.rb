MANDRILL_API_KEY = 'gcrNvxYNhBtbIJWzwqQQzw'

ActionMailer::Base.smtp_settings = {
	address: "smtp.mandrillapp.com",
	port: 587,
	enable_starttls_auto: true,
	username: 'clickapps',
	#password = api_key
	password: 'gcrNvxYNhBtbIJWzwqQQzw',
	authentication: 'login'
}

ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.default charset: 'utf-8'

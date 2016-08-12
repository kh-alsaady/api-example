class MandrillMailerExample < ApplicationMailer

require "mandrill"

default from: 'k.alsaady@clickapps.co'
default to: 'kh.alsaady@gmail.com'

def mandrill_client
	@mandrill_client ||= Mandrill::API.new MANDRILL_API_KEY
end

def send_email
	# template_name = 'template_name_as_in_mondrill_site'
  template_name = 'test-template'
	template_content = []
	message = {
		to: [{email: 'kh.alsaady@gmail.com'}],#, {email: '', name: ''}],
		subject: 'Test mandrill ',
		merge_vars: [
			{
				rcpt: 'kh.alsaady@gmail.com',
				vars: [
					{
						# name: 'Varible_name_as_declared_in_website',
            name: 'today_date',
						content: Date.today
					}
        ]#,
					# {
					# 	name: 'Varible_name_as_declared_in_website',
					# 	content: 'value'
					# }
			}
		]
	}

	# send email using mandrill
	mandrill_client.messages.send_template(template_name, template_content, message)
end
end

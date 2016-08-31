class Api::V1::TwilioExamplesController < ApplicationController

  def send_sms

    to      = params['to']
    message = params['body']

    begin

      client = Twilio::REST::Client.new(ENV['account_sid'], ENV['auth_token'])
      msg = client.messages.create(
      # phone number should be with + sign and country code
        # personal number
        # from: '+16578889157',
        # clickapps number
        from: "+16502765772",
        to: to,
        # to: '+917087225996',
        # body limited to 1600 characters.
        body: message
        # Send image in a message The media size limit is 5MB
        # wilio supports image/gif, image/png, and image/jpeg mime-types and accepts many others.
        # media_url: 'http://www.tutorialspoint.com/estimation_techniques/images/functions.jpg'
        # ProvideFeedback: true,
        # StatusCallback: 'http://1cf23bd7.ngrok.io/api/v1/twilio/twilio_callback'

      )

      msg_id = msg.sid
      message = client.messages.get(msg_id)

      render json: {message: true, message_status: message.status }

    rescue Exception => e
      render json: {message: false, data: e.message}
    end
  end

  def receive_sms
    message = params['Body'] || "No message received"
    puts message

    twiml = Twilio::TwiML::Response.new do |r|
      r.Message "Thank you for messaging me"
    end

    render xml: twiml.text
  end

  def twilio_callback
    client = Twilio::REST::Client.new(ENV['account_sid'], ENV['auth_token'])
    msg_id = params[:MessageSid]
    message = client.messages.get(msg_id)

    debugger
    #render json: {message: true, data: 'success'}
  end



end

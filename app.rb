require 'sinatra'
require 'twilio-ruby'

use Rack::TwilioWebhookAuthentication, ENV['AUTH_TOKEN'], '/message/forward'


get '/' do
	"You are good to go. Now put the url #{request.url}message/forward/?to=your-10-digit-phone-number into your Messaging URL on your phone number in the Twilio Account interface.
	See instructions: <a href='https://www.twilio.com/help/faq/sms/how-do-i-assign-my-twilio-number-to-my-sms-application'>https://www.twilio.com/help/faq/sms/how-do-i-assign-my-twilio-number-to-my-sms-application</a>" 
end

post '/message/forward/?' do
	# take the forward number from the URL parameter 
	# and the content of the message from the POST param
	# we then concatenate a message telling who the SMS is from
	
	forward_number = params[:to]
	body = "#{params[:Body]} 🙋"

	#create a Twiml Response object
	response = Twilio::TwiML::Response.new do |r|
		r.Message body, to: forward_number
	end
	response.text

end

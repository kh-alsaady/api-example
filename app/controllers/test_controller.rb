class TestController < ApplicationController
	skip_before_action :authenticate

	def run_rake_task
		x = 'Hello'
		status = system "rake khalid_tasks:print_x x=#{x} "
		return render json: {success: false, message: 'An Error occured while executed Rake Task '}, status: 400  unless status
	    render json: {success: true, message:
	     'Rake Task executed successfully'}, status: 200
	end

	def index
		data = TodoList.last
	    render json: {success: true, message: 'success', data: TestSerializer.new(data, scope: {lang_code: 'en'})}, status: 200
	end


	
end

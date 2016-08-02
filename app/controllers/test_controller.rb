class TestController < ApplicationController
	skip_before_action :authenticate

	def index
		# send scope
		data	= TestSerializer.new(TodoList.last)

    render json: {success: true, data: data}, status: 200
	end


end

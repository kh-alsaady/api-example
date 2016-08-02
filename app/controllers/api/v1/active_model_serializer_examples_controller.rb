class Api::V1::ActiveModelSerializerExamplesController < Api::V1::BaseController
  skip_before_action :authenticate


	def test_scope
		# send scope
		data	= ActiveModelSerializerExampleSerializer.new(TodoList.last, scope: tested_value, scope_name: 'tested_value')
    
		# data	= TestSerializer.new(TodoList.last, scope: tested_value)
    render json: {success: true, data: data}, status: 200
	end

	def tested_value
		'khalid'
	end
end

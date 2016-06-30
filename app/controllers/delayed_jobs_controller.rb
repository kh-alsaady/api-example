class DelayedJobsController < ApplicationController
  
  def index
  	TodoList.first.update_updated_at_date
  	render json: {success: true, message: 'success'}, status: 200  
  end

end

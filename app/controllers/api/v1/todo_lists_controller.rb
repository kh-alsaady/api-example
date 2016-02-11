class Api::V1::TodoListsController < Api::V1::BaseController
  # ============= callbacks =================== #
  before_action :set_todo_list, only: [:show, :update, :destroy]
  
  # resource description used by apipie
  resource_description do
	short "API's for managing TodoList Actions"
  end
  
  # common parameter
  def_param_group :todo_list do
	param :title, String, desc: 'title of todo_list item', required: true
	param :description, String, desc: 'description of todo_list item', required: true
	param :avatar, ActionDispatch::Http::UploadedFile, desc: 'an image for todo_list', optional: true
  end
  
  # ============= actions  =================== #
  api 'GET', "/api/v1/todo_lists", "Get all todo_list items" 
  def index
	@todo_lists = TodoList.all.includes(:todo_items).references(:todo_items)
	# serialize @todo_lists
  	@todo_lists = ActiveModel::ArraySerializer.new @todo_lists, each_serializer: TodoListSerializer, root: false 
    #@todo_lists = TodoList.all.map{|item| serialize(item)}	
    render json: {success: true, message: I18n.t('todo_list.success_msg'), todo_lists: @todo_lists}, status: 200    
  end
  
  api 'GET', '/api/v1/todo_lists/:id', 'show specific todo_list item'
  param :id, Integer, desc: 'id for todo_list which will be display', required: true  
  def show
    @todo_list = serialize @todo_list
    render json: {success: true, message: I18n.t('todo_list.success_msg'), todo_list: @todo_list}, status: 200
  end
  
  api 'POST', '/api/v1/todo_lists', 'Create new tod_list item'
  param_group :todo_list
  def create
	begin
      @todo_list = TodoList.new todo_list_params    
      if @todo_list.save
		@todo_list = serialize @todo_list
        render json: {success: true, message: I18n.t('todo_list.success_add_msg'), todo_list: @todo_list}, status: 201
      else
        error_msgs = @todo_list.errors.full_messages
        render json: {success: false, message: I18n.t('errors.fail_msg'), errors: error_msgs}, status: 422
      end
	rescue Exception => e
	  render :json => { success: false, message: e.message, data: {} }, :status => 400  
	end
  end
  
  api 'PATCH', 'api/v1/todo_lists/:id', 'Update existing tod_list item'
  param :id, Integer, desc: 'id for todo_list item which will be update', required: true
  param_group :todo_list  
  def update      
    if @todo_list.update todo_list_params
	  @todo_list = serialize @todo_list
      render json: {success: true, message: I18n.t('todo_list.success_update_msg'), todo_list: @todo_list}, status: 201
    else
      error_msgs = @todo_list.errors.full_messages
      render json: {success: false, message: I18n.t('errors.fail_msg'), errors: error_msgs}, status: 422
    end    
  end
  
  api 'DELETE', 'api/v1/todo_lists/:id', 'Delete existing tod_list item'
  param :id, Integer, desc: 'id for todo_list item which will be delete', required: true
  def destroy
    @todo_list.destroy
    render json: {success: true, message: I18n.t('todo_list.success_del_msg'), data: {}}, status: :ok
  end
  
  # ============= Private functions ======================= #
  private
    def todo_list_params
        params.permit :title, :description, :avatar
    end
    
    def set_todo_list
      @todo_list = TodoList.find_by_id(params[:id])
      return render json: {success: false, message: I18n.t('errors.record_not_found'),data: {}}, status: 422 unless @todo_list
    end
    
    # custom method for serialize item
    def serialize(item, include_root = false)
	  TodoListSerializer.new(item, root: include_root)
    end
end

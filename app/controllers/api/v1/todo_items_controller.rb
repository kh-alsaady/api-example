class Api::V1::TodoItemsController < Api::V1::BaseController
  # callbacks
  before_action :set_todo_list
  before_action :set_todo_item, only: [:show, :update, :destroy]  
  
  # resource description used by apipie
  resource_description do
	short "API's for managing TodoItem Actions for specific TodoList"
	# common param between all actions
	param :todo_list_id, Integer, desc: 'id of todo_list', required: true
  end
  
  def_param_group :todo_item do
    param :title, String, 'title of todo_item', required: true
    param :description, String, 'description of todo_item', required: true
  end
  
  # for apipie documentations
  api 'GET', "/api/v1/todo_lists/:todo_list_id/todo_items", "Get todo_items for specific todo_list"  
  def index    
    @todo_items = @todo_list.todo_items.map{ |item| serialize item}
    render json: {success: true, message: I18n.t('success.success_msg'), todo_items: @todo_items}, status: 200
  end
  
  api 'GET', "/api/v1/todo_lists/:todo_list_id/todo_items/:id", 'show specific todo_item for specific todo_list'
  param :id, Integer, desc: 'id of todo_item which will be display', required: true  
  def show
    @todo_item = serialize @todo_item
    render json: {success: true, message: I18n.t('success.success_msg'), todo_item: @todo_item}, status: 200
  end
  
  api 'POST', '/api/v1/todo_lists/:todo_list_id/todo_items', 'Create new tod_item'  
  param_group :todo_item  
  def create
    @todo_item = @todo_list.todo_items.new todo_item_params    
    if @todo_item.save
      @todo_item = serialize @todo_item
      render json: {success: true, message: I18n.t('todo_item.success_add_msg'), todo_item: @todo_item}, status: 201
    else
      error_msgs = @todo_item.errors.full_messages
      render json: {success: false, message: I18n.t('errors.fail_msg'), errors: error_msgs}, status: 422
    end    
  end
  
  api 'PATCH', 'api/v1/todo_lists/:todo_list_id/todo_items/:id', 'Update an existing tod_item'  
  param :id, Integer, desc: 'id of todo_item  which will be update', required: true  
  param_group :todo_item  
  def update      
    if @todo_item.update todo_item_params
      @todo_item = serialize @todo_item
      render json: {success: true, message: I18n.t('todo_item.success_update_msg'), todo_item: @todo_item}, status: 201
    else
      error_msgs = @todo_item.errors.full_messages
      render json: {success: false, message: I18n.t('errors.fail_msg'), errors: error_msgs}, status: 422
    end    
  end
  
  api 'DELETE', 'api/v1/todo_lists/:todo_list_id/todo_items/:id', 'Delete an existing tod_item'
  param :id, Integer, desc: 'id of todo_item which will be delete', required: true  
  def destroy
    @todo_item.destroy
    render json: {success: true, message: I18n.t('todo_item.success_del_msg'), data: {}}, status: :ok
  end
  
  # ============= Private functions ======================= #
  private
    def todo_item_params
        params.permit :title, :description, :todo_list_id
    end
    
    def set_todo_item
      @todo_item = @todo_list.todo_items.find_by_id(params[:id])
      return render json: {success: false, message: I18n.t('errors.record_not_found'),data: {}}, status: 422 unless @todo_item
    end
    
    def set_todo_list
      @todo_list = TodoList.find_by_id(params[:todo_list_id])
      return render json: {success: false, message: I18n.t('todo_item.todo_list_not_found'),data: {}}, status: 422 unless @todo_list
    end
    
    def serialize item, include_root = false
	  TodoItemSerializer.new(item, root: include_root)
    end
end

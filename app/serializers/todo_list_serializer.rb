class TodoListSerializer < ActiveModel::Serializer
  # attributes which will be serialize
  attributes :id, :title, :description, :avatar #, :todo_items
  
  has_many :todo_items

  # def avatar
  #   # we serialize avatar to include the full path as following
  #   object.avatar? ? ActionController::Base.asset_host + object.avatar.url(:original) : ActionController::Base.asset_host + "/images/missing.png" 
  # end
  
  # another way to include todo_items
  #def todo_items
  #  ActiveModel::ArraySerializer.new object.todo_items, serializer: TodoItemSerializer 
  #end
end

class TodoListSerializer < ActiveModel::Serializer
  # attributes which will be serialize
  attributes :id, :title, :description
  
  has_many :todo_items
end

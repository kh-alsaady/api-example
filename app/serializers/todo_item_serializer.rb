class TodoItemSerializer < ActiveModel::Serializer
  # attributes which will be serialize
  attributes :id, :title, :description
  
end

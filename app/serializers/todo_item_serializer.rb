class TodoItemSerializer < ActiveModel::Serializer
  # attributes which will be serialized
  attributes :id, :title, :description, :avatar

  # def avatar
  #   # we serialize avatar to include the full path as following
  #   object.avatar? ? ActionController::Base.asset_host + object.avatar.url(:original) : ActionController::Base.asset_host + "/images/missing.png" 
  # end
  
  
end

class AddAvatarToItemsAndListsTables < ActiveRecord::Migration
  def self.up
  	add_attachment :todo_lists, :avatar
  	add_attachment :todo_items, :avatar
  end

  def self.down
  	remove_attachment :todo_lists, :avatar
  	remove_attachment :todo_items, :avatar
  end
end

class CreateTodoItems < ActiveRecord::Migration
  def change
    create_table :todo_items do |t|
      t.string :title
      t.string :description
      t.integer :todo_list_id
      t.timestamps null: false
    end
  end
end

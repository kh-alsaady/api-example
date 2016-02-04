class TodoItem < ActiveRecord::Base
  # ========== validations =================== #
  validates :title, :description, :todo_list_id, presence: true
  validates :title, :description, uniqueness: true
  
  # ========== associations =================== #
  belongs_to :todo_list
  
end

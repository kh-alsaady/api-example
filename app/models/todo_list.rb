class TodoList < ActiveRecord::Base
  # ========== validations =================== #
  validates :title, :description, presence: true, uniqueness: true
  
  # ========== associations =================== #
  has_many :todo_items
end

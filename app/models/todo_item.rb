class TodoItem < ActiveRecord::Base

  # code for Avatar written in models/concerns
  include Avatar

  # ========== validations =================== #
  validates :title, :description, :todo_list_id, presence: true
  validates :title, :description, uniqueness: true
  scope :last_five, lambda{ |x| limit x}
  # ========== associations =================== #
  belongs_to :todo_list


end

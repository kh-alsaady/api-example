class TodoList < ActiveRecord::Base

  # code for Avatar written in models/concerns
  include Avatar

  # validations 
  validates :title, :description, presence: true, uniqueness: true
  
  # associations 
  has_many :todo_items


end

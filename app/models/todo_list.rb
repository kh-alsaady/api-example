class TodoList < ActiveRecord::Base

  # code for Avatar written in models/concerns
  include Avatar

  # validations 
  validates :title, :description, presence: true, uniqueness: true
  
  # associations 
  has_many :todo_items

  def update_updated_at_date
  	TodoList.all.each do |i|
  		i.update updated_at: Time.now
  		i.save!(validate: false)
  	end
  end
  handle_asynchronously :update_updated_at_date, run_at: 10.seconds.from_now

end

namespace :khalid_tasks do

	desc "My rake task 1"
	
	task :task1 => :environment do 
		sleep 5
		puts 'Task 1 has been executed'
	end

	desc "My rake task 2"

	task :task2 do
		puts 'Task 2 has been executed'
	end

	desc 'Add new todolist item'

	task :create_new_todo_list => :environment do
		TodoList.create(title: 'new title', description: 'desc1')
	end

	desc 'print x value'

	task :print_x do
		puts ENV['x']
	end

end
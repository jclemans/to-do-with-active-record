require 'active_record'
require './lib/task'
require './lib/list'

database_configurations = YAML::load(File.open('./db/config.yml'))
development_configuration = database_configurations['development']
ActiveRecord::Base.establish_connection(development_configuration)

def welcome
  puts "Welcome to the To Do list!"
  list_menu
end

def list_menu
  choice = nil
  until choice == 'e'
    puts "Press 'a' to add a list, 'l' to list your lists 'v' to view a specific list."
    puts "Press 'e' to exit."
    choice = gets.chomp
    case choice
    when 'a'
      add_list
    when 'l'
      list_lists
    when 'v'
      puts 'Please enter the name of the list you which to view.'
      list_name = gets.chomp
      list = List.where({name: list_name})
      task_menu(list.first)
    when 'e'
      puts "Goodbye!"
    else
      puts "Invalid input!"
    end
  end
end

def task_menu(list)
  task_choice = nil
  until task_choice == 'e'
    puts "Press 'a' to add a task, 'l' to list your tasks, or 'd' to mark a task as done."
    puts "Press 'e' to go back."
    task_choice = gets.chomp
    case task_choice
    when 'a'
      add_task(list)
    when 'l'
      list_tasks(list)
    when 'd'
      mark_done(list)
    when 'e'
    else
      puts "Invalid input!"
    end
  end
end

def add_task(list)
  puts "What do you need to do?"
  task_name = gets.chomp
  task = list.tasks.new({name: task_name, done: false})
  task.save
  "'#{task_name}' has been added to your To Do List."
end

def list_tasks(list)
  puts list.class
  puts "Here is everything you need to do:"
  list.tasks.not_done.each { |task| puts task.name }
end

def mark_done(list)
  puts "Which task would you like to mark as done?"
  list.tasks.all.each { |task| puts task.name }

  done_task_name = gets.chomp
  done_task = list.tasks.where({name: done_task_name}).first
  done_task.update({done: true})
end

def list_lists
  puts "Here is a list of your lists!"
  List.all.each { |list| puts list.name }
end

def add_list
  puts "What is the name of your list?"
  list_name = gets.chomp
  list = List.new({name: list_name})
  list.save
  "'#{list_name}' has been added to your To Do List."
end

welcome






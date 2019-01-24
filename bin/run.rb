require_relative '../config/environment'
require 'rest-client'
require 'json'
require 'tty-prompt'

require 'pry'

class Cli

  attr_reader :user

  def welcome
    prompt = TTY::Prompt.new
    user_name = prompt.ask('What is your name?')
    if User.all.find {|users| users.name == user_name}
      puts "Welcome back, #{user_name}!"
      @user = User.find_by(name: user_name)
    else
      puts "Welcome, #{user_name}!"
      result = prompt.collect do
        # key(:name) => user_name
        key(:age).ask('Age?', convert: :int)
        key(:weight).ask('Weight (lb)?', convert: :int)
        key(:height).ask('Height (in)?', convert: :int)
        key(:gender).ask('Gender (M/F)?', convert: :string)
        key(:goal_weight).ask('Goal weight (lb)?', convert: :int)
        key(:goal_timeline).ask('Goal timeline (days)?', convert: :int)
      end
      new_user = User.create(result)
      new_user.update(name: user_name)
      @user = new_user
    end
  end

  def menu
    prompt = TTY::Prompt.new
    user_response = prompt.select("What would you like to do?") do |menu|
    menu.choice 'View my bmr/bmi'
    menu.choice 'View my total daily intake'
    menu.choice 'Add food'
    menu.choice 'View food list'
    menu.choice 'View macro intake'
    menu.choice 'Exit menu'
    end
  end

  def view_bmr_bmi
    puts "bmi: #{@user.calculate_bmi}"
    puts "bmr: #{@user.calculate_bmr}"
  end

  def exit_menu
    puts "Goodbye"
  end

  def add_food(food,num)
    food_name_arr = Food.get_top_food_results(food,num)
    prompt = TTY::Prompt.new
    user_response = prompt.select("Were you looking for..") do |menu|
    menu.choice "#{food_name_arr[0]}"
    menu.choice "#{food_name_arr[1]}"
    menu.choice "#{food_name_arr[2]}"
    menu.choice "#{food_name_arr[3]}"
    menu.choice "#{food_name_arr[4]}"
    end
    @user.foods.create(name: user_response)
  end




  def runner
    user = welcome
    case menu
    when 'View my bmr/bmi'
      view_bmr_bmi
    when 'Exit menu'
      exit_menu
    when 'Add food'
      puts "Search food item"
      food = gets.chomp
      add_food(food,5)
    else
      menu
    end

  end

end # end of class

Cli.new.runner

binding.pry

puts "HELLO WORLD"

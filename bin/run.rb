require_relative '../config/environment'
require 'rest-client'
require 'json'
require 'tty-prompt'

require 'pry'

class Cli

  attr_accessor :user

  def welcome
    prompt = TTY::Prompt.new
    user_name = prompt.ask("What is your name?") do |q|
      q.required true
      q.validate /\A\w+\Z/
      q.modify   :capitalize
    end
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
        key(:activity_level).ask('Activity level (1(sedentary)-5(very active))?', convert: :int)
      end
      new_user = User.create(result)
      new_user.update(name: user_name)
      self.user = new_user
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
    menu.choice 'View daily cal intake for goal'
    menu.choice 'View daily cal intake to maintain weight'
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
      food_name_arr.each do |el|
        menu.choice "#{el.split(', UPC')[0]}"
      end
    end
    self.user.foods.create(name: user_response)
    # f = Food.create(name:user_response)
  end

  def list_foods
    self.user.foods.map do |food|
      puts food.name.split(', UPC')[0]
    end
  end

  def total_daily_cal_intake
    total = 0
    self.user.foods.map do |food|
      total += food.calories
    end
    puts total
  end

  def runner
    user = welcome
    user_input = ""
    not_quit = true
    while not_quit
      case menu
      when 'View my bmr/bmi'
        view_bmr_bmi
      when 'Exit menu'
        exit_menu
        not_quit = false
      when 'Add food'
        puts "Search food item"
        food = gets.chomp
        add_food(food,5)
      when 'View food list'
        list_foods
      when 'View my total daily intake'
        puts @user.total_daily_cal_intake
      when 'View macro intake'
        puts @user.total_daily_macro_intake
      when 'View daily cal intake for goal'
        puts "#{user.cal_intake_for_goal} calories"
      when 'View daily cal intake to maintain weight'
        puts "#{user.cal_intake_to_maintain} calories"
      else
        menu
      end
    end

  end

end # end of class

c = Cli.new
c.runner

binding.pry

puts "HELLO WORLD"

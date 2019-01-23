require_relative '../config/environment'
require 'rest-client'
require 'json'

require 'pry'
# def get_food_from_api(food)
#   #make the web request
#   # puts 'in get character'
#   nutrient_report_url = "https://api.nal.usda.gov/ndb/nutrients/?format=json&api_key=DEMO_KEY&nutrients=205&nutrients=204&nutrients=208&nutrients=269&fg=0100&fg=0500"
#   response_string = RestClient.get(apikey)
#   response_hash = JSON.parse(response_string)
#   # binding.pry
#   response_hash.fetch('foods').each do |f|
#     puts f["food"]["desc"]
#   end
#   # binding.pry
# end

# def search_by_food(food)
#   search_url = "https://api.nal.usda.gov/ndb/search/?format=json&q=#{food}&sort=n&max=25&offset=0&api_key=m7tJlPDeol0BRpU94StlarX7J2owCr33rxxJS8mP"
#   response_search = RestClient.get(search_url)
#   search_hash = JSON.parse(response)
#   ndbno = search_hash['list']['item']['ndbno']
#   return ndbno
# end
#
# def get_nutrients(ndbno)
#   nutrient_report_url = "https://api.nal.usda.gov/ndb/nutrients/?format=json&q=#{ndbno}&api_key=DEMO_KEY&nutrients=205&nutrients=204&nutrients=208&nutrients=269&fg=0100&fg=0500"
#   response_nutrient = RestClient.get(nutrient_report_url)
#   nutrient_hash = JSON.parse(response_nutrient)
#
# end

def get_user_details
  puts "Enter first name:"
  first_name = gets.chomp
  puts "Enter last name:"
  last_name = gets.chomp
  puts "Enter age:"
  age = gets.chomp
  puts "Enter weight (lb):"
  weight = gets.chomp
  puts "Enter height (in):"
  height = gets.chomp
  puts "Enter gender('M'/'F'):"
  gender = gets.chomp
  puts "Enter goal weight(lb): "
  goal_weight = gets.chomp
  User.new(first_name, last_name, age, weight, height, gender,goal_weight)
end
pizza = Food.new(name: 'pizza')
pizza_arr= pizza.get_nutrient_hash
pizza.get_calories(pizza_arr)
pizza.get_nutrional_values(pizza_arr,'Fats',pizza.fats)

puts "HELLO WORLD"

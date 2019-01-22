require_relative '../config/environment'
require 'rest-client'
require 'json'

require 'pry'
def get_food_from_api(food)
  #make the web request
  # puts 'in get character'
  apikey = "https://api.nal.usda.gov/ndb/search/?format=json&q=#{food}&sort=n&max=25&offset=0&api_key=m7tJlPDeol0BRpU94StlarX7J2owCr33rxxJS8mP"
  response_string = RestClient.get(apikey)
  response_hash = JSON.parse(response_string)
  binding.pry
  response_hash.fetch('foods').each do |f|
    puts f["food"]["desc"]
  end
  # binding.pry
end

get_food_from_api('cookies')
puts "HELLO WORLD"

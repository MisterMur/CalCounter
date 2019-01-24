
class Food < ActiveRecord::Base
  has_many :meals
  has_many :users, through: :meals

  NUTRIENT_IDS = {'Calories'=> '208' , 'Carbs' => '205','Fats' => '204' }

  after_initialize {search_by_food(name)}
  after_initialize  {get_nutrional_values('Fats')}
  after_initialize  {get_nutrional_values('Calories')}
  after_initialize  {get_nutrional_values('Carbs')}

  def search_by_food(food)
    #queries usda search table api by food and returns the ndbo (food id)
    # to be searched against the usda nutrients table api
    puts 'in search by food'
    search_url = "https://api.nal.usda.gov/ndb/search/?format=json&q=#{food}&sort=n&max=1&offset=0&api_key=m7tJlPDeol0BRpU94StlarX7J2owCr33rxxJS8mP"
    response_search = RestClient.get(search_url)
    search_hash = JSON.parse(response_search)
    # binding.pry
    search_ndbno = search_hash['list']['item'][0]['ndbno']
    self.ndbno = search_ndbno
  end

  def self.get_top_food_results(food,num_items)
    #returns num_items amount of food names
    puts 'in top food results'
    search_url = "https://api.nal.usda.gov/ndb/search/?format=json&q=#{food}&sort=n&max=#{num_items}&offset=0&api_key=m7tJlPDeol0BRpU94StlarX7J2owCr33rxxJS8mP"
    response_search = RestClient.get(search_url)
    search_hash = JSON.parse(response_search)
    search_hash['list']['item'].map do |item|
      item['name']
    end

  end

  def select_food(ndbno)
    food = food_arr.find do |food_item|
      food_item['ndbno'] == ndbno
    end
    food
  end


  def get_nutrient_hash()
    #returns an array of hashes,from what we request from api
     # each hash is a different nutrient(name,value,measurement etc)
    nutrient_report_url = "https://api.nal.usda.gov/ndb/nutrients/?format=json&ndbno=#{self.ndbno}&max=1&offset=0&api_key=m7tJlPDeol0BRpU94StlarX7J2owCr33rxxJS8mP&nutrients=205&nutrients=204&nutrients=208&nutrients=269"
    response_nutrient = RestClient.get(nutrient_report_url)
    nutrient_hash = JSON.parse(response_nutrient)
    n = nutrient_hash['report']['foods'][0]#['nutrients']
  end


  def get_nutrional_values(nut_name)
    #itterates through the array of hashes searching for
    #nutrient  we are looking for based on nut_name passed in
    nutrients_arr = get_nutrient_hash()['nutrients']
    cals_hash= nutrients_arr.find do |nutrient|
      nutrient['nutrient_id'] == NUTRIENT_IDS[nut_name]
    end
    nut_value = cals_hash['value']
    add_value_to_local_variable(nut_name, nut_value)
  end

  def add_value_to_local_variable(name, value)
    #assigns the value to the instances variables based on name
    # if passed in 'calories' will assign value to the instance  self.calories
    case name
    when "Fats"
      self.fats = value.to_f
    when 'Calories'
      self.calories = value.to_f
    when 'Carbs'
      self.carbs = value.to_f
    when 'Proteins'
      self.proteins = value.to_f
    end
  end

end #end Food Class

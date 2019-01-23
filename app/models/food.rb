
class Food < ActiveRecord::Base
  has_many :meals
  has_many :users, through: :meals

  attr_reader :name
  attr_accessor :ndbno,:calories,:fats,:carbs,:proteins
  NUTRIENT_IDS = {'Calories'=> '208' , 'Carbs' => '205','Fats' => '204' }
  def initialize(name: name)
    super
    @name = name
    @ndbno = search_by_food(@name)
    get_nutrional_values('Fats')
    get_nutrional_values('Calories')
    get_nutrional_values('Carbs')

  end


  def search_by_food(food)
    #queries usda search table api by food and returns the ndbo (food id)
    # to be searched against the usda nutrients table api

    search_url = "https://api.nal.usda.gov/ndb/search/?format=json&q=#{food}&sort=n&max=1&offset=0&api_key=m7tJlPDeol0BRpU94StlarX7J2owCr33rxxJS8mP"
    response_search = RestClient.get(search_url)
    search_hash = JSON.parse(response_search)
    search_ndbno = search_hash['list']['item'][0]['ndbno']
    # binding.pry

    search_ndbno
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
    # binding.pry

  end

  def add_value_to_local_variable(name, value)
    #assigns the value to the instances variables based on name
    # if passed in 'calories' will assign value to the instance  self.calories
    case name
    when "Fats"
      @fats = value.to_f
    when 'Calories'
      @calories = value.to_f
    when 'Carbs'
      @carbs = value.to_f

    end
  end

end #end Food Class

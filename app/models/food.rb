
class Food < ActiveRecord::Base
  has_many :meals
  has_many :users, through: :meals

  attr_reader :name
  attr_accessor :ndbno,:calories,:fats,:carbs,:proteins

  def initialize(name: name)
    super
    @name = name
    @ndbno = search_by_food(@name)
     # binding.pry
     # nutrients = get_nutrients


  end


  def search_by_food(food)
    search_url = "https://api.nal.usda.gov/ndb/search/?format=json&q=#{food}&sort=n&max=1&offset=0&api_key=m7tJlPDeol0BRpU94StlarX7J2owCr33rxxJS8mP"
    response_search = RestClient.get(search_url)
    search_hash = JSON.parse(response_search)
    search_ndbno = search_hash['list']['item'][0]['ndbno']
    # binding.pry

    search_ndbno
  end

  def get_nutrients()
    nutrient_report_url = "https://api.nal.usda.gov/ndb/nutrients/?format=json&ndbno=#{self.ndbno}&max=1&offset=0&api_key=m7tJlPDeol0BRpU94StlarX7J2owCr33rxxJS8mP&nutrients=205&nutrients=204&nutrients=208&nutrients=269"
    response_nutrient = RestClient.get(nutrient_report_url)
    nutrient_hash = JSON.parse(response_nutrient)

    nutrient_hash['report']['foods'][0]['nutrients']
    binding.pry
    # binding.pry
    # 45207185
  end

end

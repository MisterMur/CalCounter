
class Food < ActiveRecord::Base

  attr_reader :name
  attr_accessor :ndbno

  def initialize(args={})
    super
    @name = :name

    @ndbno= search_by_food(name)
    # binding.pry
  end


  def search_by_food(food)
    search_url = "https://api.nal.usda.gov/ndb/search/?format=json&q=#{food}&sort=n&max=1&offset=0&api_key=m7tJlPDeol0BRpU94StlarX7J2owCr33rxxJS8mP"
    response_search = RestClient.get(search_url)
    search_hash = JSON.parse(response_search)
    search_ndbno = search_hash['list']['item'][0]['ndbno']
    return search_ndbno
  end

  def get_nutrients(ndbno)
    nutrient_report_url = "https://api.nal.usda.gov/ndb/nutrients/?format=json&ndbno=#{ndbno}&max=1&offset=0&api_key=m7tJlPDeol0BRpU94StlarX7J2owCr33rxxJS8mP&nutrients=205&nutrients=204&nutrients=208&nutrients=269"
    response_nutrient = RestClient.get(nutrient_report_url)
    nutrient_hash = JSON.parse(response_nutrient)

  end

end

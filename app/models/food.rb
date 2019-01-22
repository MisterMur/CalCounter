
class Food < ActiveRecord::Base




  def search_by_food(food)
    search_url = "https://api.nal.usda.gov/ndb/search/?format=json&q=#{food}&sort=n&max=25&offset=0&api_key=m7tJlPDeol0BRpU94StlarX7J2owCr33rxxJS8mP"
    response_search = RestClient.get(search_url)
    search_hash = JSON.parse(response)
    ndbno = search_hash['list']['item']['ndbno']
    return ndbno
  end

  def get_nutrients(ndbno)
    nutrient_report_url = "https://api.nal.usda.gov/ndb/nutrients/?format=json&q=#{ndbno}&api_key=DEMO_KEY&nutrients=205&nutrients=204&nutrients=208&nutrients=269&fg=0100&fg=0500"
    response_nutrient = RestClient.get(nutrient_report_url)
    nutrient_hash = JSON.parse(response_nutrient)

  end

end

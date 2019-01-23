Food.all.each do |food|
  food_name = food.name

  data = hit_api(food_name)

  # 1
  # food.update({calories: data["calories"]})

  # 2
  # food.calories = data["calories"]
  # food.save
end

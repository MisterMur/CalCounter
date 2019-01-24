
class User < ActiveRecord::Base
  has_many :meals
  has_many :foods, through: :meals


  def calculate_bmi
    (self.weight * 703)/(self.height)**2
  end

  def calculate_bmr #Harris-Benedict Formula
    bmr = nil
    if self.gender == "M" #update run.rb gender puts to only accept "M" or "F"
      bmr = 66 + (6.3*self.weight) + (12.9*self.height) - (6.8*self.age)
    else
      bmr = 655 + (4.3*self.weight) + (4.7*self.height) - (4.7*self.age)
    end
    bmr
  end

  def cal_intake_to_maintain
    #update run.rb to ask for activity level (1-5)
    # 1 - sedentary (little or no exercise)
    # 2 - lightly active (light exercise/sports 1-3 days/week)
    # 3 - moderately active (moderate exercise/sports 3-5 days/week)
    # 4 - very active (hard exercise/sports 6-7 days/week)
    # 5 - extra active (very hard exercise/sports & physical job or 2x training)
    cals_to_maintain = nil
    case self.activity_level
    when 1
      cals_to_maintain = self.calculate_bmr * 1.2
    when 2
      cals_to_maintain = self.calculate_bmr * 1.375
    when 3
      cals_to_maintain = self.calculate_bmr * 1.55
    when 4
      cals_to_maintain = self.calculate_bmr * 1.725
    when 5
      cals_to_maintain = self.calculate_bmr * 1.9
    end
    cals_to_maintain
  end

  def cal_intake_for_goal
    weight_adjustment = self.goal_weight - self.weight
    #positive if goal is to gain weight
    #negative if goal is to lose weight
    weight_adjustment_per_day = (weight_adjustment/self.goal_timeline.to_f)
    calorie_adjustment_per_day = weight_adjustment_per_day * 3500
    calorie_adjustment_per_day + self.cal_intake_to_maintain
    # binding.pry
  end

  def total_daily_cal_intake
    total_cals = 0
    self.foods.each do |food|
      total_cals += food.calories
    end
    total_cals
  end

  def total_daily_macro_intake
    total_fats = 0
    total_carbs = 0
    # total_proteins =0
    self.foods.each do |food|
      total_carbs += food.carbs
      total_fats += food.fats
      # total_proteins += food.proteins
    end
    {'Carbs'=> total_carbs,'Fats' => total_fats}
    # {'Proteins'=>total_proteins,'Carbs'=> total_carbs,'Fats' => total_fats}
  end

  def remaining_daily_cal_intake
    remaining_cals_to_consume = nil
    if self.cal_intake_for_goal > self.total_daily_cal_intake
      remaining_cals_to_consume = self.cal_intake_for_goal - self.total_daily_cal_intake
    else
      remaining_cals_to_consume = 0
    end
    remaining_cals_to_consume
  end

# binding.pry
end

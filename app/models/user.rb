
class User < ActiveRecord::Base
  has_many :meals
  has_many :foods, through: :meals

  attr_accessor :first_name,:last_name,:age,:weight,:height,:gender, :goal_weight, :goal_timeline


  # def initialize(id=nil,first_name, last_name, age, weight, height, gender, goal_weight)
  #   @first_name = first_name
  #   @last_name = last_name
  #   @age = age
  #   @weight = weight
  #   @height = height
  #   @gender = gender
  #   @goal_weight = goal_weight
  # end

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

  def goal_cal_intake_to_maintain_weight
    #update run.rb to ask for activity level (1-5)
    # 1 - sedentary (little or no exercise)
    # 2 - lightly active (light exercise/sports 1-3 days/week)
    # 3 - moderately active (moderate exercise/sports 3-5 days/week)
    # 4 - very active (hard exercise/sports 6-7 days/week)
    # 5 - extra active (very hard exercise/sports & physical job or 2x training)
    cals_to_maintain = nil
    case activity_level
    when 1
      cals_to_maintain = bmr * 1.2
    when 2
      cals_to_maintain = bmr * 1.375
    when 3
      cals_to_maintain = bmr * 1.55
    when 4
      cals_to_maintain = bmr * 1.725
    when 5
      cals_to_maintain = bmr * 1.9
    end
    cals_to_maintain
  end

  def goal_cal_intake_for_goal_weight
    weight_to_gain_or_lose = self.goal_weight - self.weight
    #postiive if goal is to gain weight
    #negative if goal is to lose weight

  end

  def total_daily_cal_intake

  end

  def remaining_daily_cal_intake
  end

end

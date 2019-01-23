
class User < ActiveRecord::Base
  has_many :meals
  has_many :foods, through: :meals

  attr_accessor :first_name,:last_name,:age,:weight,:height,:gender

  
  def initialize(id=nil,first_name, last_name, age, weight, height, gender)
    @first_name = first_name
    @last_name = last_name
    @age = age
    @weight = weight
    @height = height
    @gender = gender
  end




end

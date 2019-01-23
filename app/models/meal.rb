
class Meal < ActiveRecord::Base
  belongs_to :foods
  belongs_to :users


end

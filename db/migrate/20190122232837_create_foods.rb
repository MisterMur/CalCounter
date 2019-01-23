class CreateFoods < ActiveRecord::Migration[5.0]
  def change
    create_table :foods do |t|
      t.string :name
      t.string  :ndbno
      t.integer :calories
      t.integer :fats
      t.integer :carbs
      t.integer :protiens
    end
  end
end

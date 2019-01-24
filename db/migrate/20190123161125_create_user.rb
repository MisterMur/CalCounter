class CreateUser < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :name
      t.integer :age
      t.integer :weight
      t.integer :height
      t.string :gender
      t.integer :goal_weight
      t.integer :goal_timeline
      t.integer :activity_level
    end
  end
end

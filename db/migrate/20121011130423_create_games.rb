class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.integer :score
      t.integer :sum
      t.float :time
      t.integer :select_num
      t.integer :select_one
      t.integer :select_two
      t.string :room_id
      t.string :game_type

      t.timestamps
    end
  end
end

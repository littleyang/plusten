class CreateSingleGames < ActiveRecord::Migration
  def change
    create_table :single_games do |t|
      t.integer :user_id
      t.integer :select_num
      t.integer :score
      t.integer :time
      t.integer :type

      t.timestamps
    end
  end
end

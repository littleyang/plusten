class ChangeSingleGamesTypeToString < ActiveRecord::Migration
  def up
    change_column :single_games,:type,:string
  end

  def down
  end
end

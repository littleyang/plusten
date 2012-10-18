class RenameSingleGamesTypeToGameType < ActiveRecord::Migration
  def up
    rename_column :single_games,:type,:game_type
  end

  def down
  end
end

class RemvoeColumnFindIdFromGames < ActiveRecord::Migration
  def up
    remove_column :games,:find_id
  end

  def down
  end
end

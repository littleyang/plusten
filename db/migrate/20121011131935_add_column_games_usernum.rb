class AddColumnGamesUsernum < ActiveRecord::Migration
  def up
    add_column :games,:usernum,:integer
  end

  def down
  end
end

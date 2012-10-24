class AddGamesRetryColumn < ActiveRecord::Migration
  def up
    add_column :games,:retry,:boolean,:default=>true
  end

  def down
  end
end

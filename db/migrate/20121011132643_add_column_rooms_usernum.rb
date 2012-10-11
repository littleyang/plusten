class AddColumnRoomsUsernum < ActiveRecord::Migration
  def up
    add_column :rooms,:usernum,:integer
  end

  def down
  end
end

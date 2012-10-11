class RemoveColumnRoomsUsernum < ActiveRecord::Migration
  def up
    remove_column :games,:usernum
  end

  def down
  end
end

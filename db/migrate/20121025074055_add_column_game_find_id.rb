class AddColumnGameFindId < ActiveRecord::Migration
  def up
    add_column :games,:find_id,:string
  end

  def down
  end
end

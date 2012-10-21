class AddColumnCurrentNum < ActiveRecord::Migration
  def up
    add_column :games,:current_num,:integer
    remove_column :games,:select_one
    remove_column :games,:select_two
    
  end

  def down
  end
end

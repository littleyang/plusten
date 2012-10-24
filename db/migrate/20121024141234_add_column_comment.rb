class AddColumnComment < ActiveRecord::Migration
  def up
    add_column :games,:comment,:integer
  end

  def down
  end
end

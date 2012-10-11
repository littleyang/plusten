class RenameColumnToGame < ActiveRecord::Migration
  def up
    rename_column :rooms,:num,:gamenum
  end

  def down
  end
end

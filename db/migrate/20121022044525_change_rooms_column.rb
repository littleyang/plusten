class ChangeRoomsColumn < ActiveRecord::Migration
  def up
    change_column :rooms,:current_user_num,:integer,:default=>0
    change_column :rooms,:current_post_num,:integer,:default=>0
  end

  def down
  end
end

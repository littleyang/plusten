class RemvoeRoomsColumn < ActiveRecord::Migration
  def up
    remove_column :rooms,:current_post_num
  end

  def down
  end
end

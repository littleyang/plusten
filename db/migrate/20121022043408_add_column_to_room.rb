class AddColumnToRoom < ActiveRecord::Migration
  def change
    add_column :rooms,:current_user_num,:string,:default=>0
    add_column :rooms,:current_post_num,:string,:default=>0
    add_column :rooms,:access,:boolean,:default=>true
  end
end

class AddColumnUserDescToUsers < ActiveRecord::Migration
  def change
    add_column :users,:userDesc,:string
  end
end

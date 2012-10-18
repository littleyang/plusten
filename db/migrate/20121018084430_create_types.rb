class CreateTypes < ActiveRecord::Migration
  def change
    create_table :types do |t|
      t.string :name
      t.integer :total_num,:default=>30

      t.timestamps
    end
  end
end

class CreateMedia < ActiveRecord::Migration[5.2]
  def change
    create_table :media do |t|
      t.string :name
      t.integer :media_type
      t.text :plot

      t.timestamps
    end
  end
end

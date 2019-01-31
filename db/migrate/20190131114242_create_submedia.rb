class CreateSubmedia < ActiveRecord::Migration[5.2]
  def change
    create_table :submedia do |t|
      t.string :name
      t.string :plot
      t.integer :sub_id
      t.integer :parent_medium_id

      t.timestamps
    end
  end
end

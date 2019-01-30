class CreateUserMedia < ActiveRecord::Migration[5.2]
  def change
    create_table :user_media do |t|
      t.integer :medium_id
      t.integer :user_id
      t.datetime :purchased_at
      t.datetime :expires_at

      t.timestamps
    end
  end
end

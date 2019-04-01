class CreateLikes < ActiveRecord::Migration[5.2]
  def change
    create_table :likes do |t|
      t.integer :chirp_id, null: false
      t.integer :user_id, null: false
      t.timestamps
    end
    add_index :likes, [:chirp_id, :user_id], unique: true
  end
end

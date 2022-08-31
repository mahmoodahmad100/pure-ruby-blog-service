class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.references :user, null: false
      t.string :title, null: false
      t.text :content, null: false
      t.string :ip_address, null: false
      t.timestamps
    end

    add_index :posts, [:user_id, :title]
  end
end

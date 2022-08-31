class CreateRatings < ActiveRecord::Migration[7.0]
  def change
    create_table :ratings do |t|
      t.references :post, null: false
      t.integer :value, null: false
      t.timestamps
    end
  end
end

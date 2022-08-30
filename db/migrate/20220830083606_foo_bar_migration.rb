class FooBarMigration < ActiveRecord::Migration[7.0]
  def change
    create_table :foo_bar do |t|
      t.string :hello
      t.string :world
      t.timestamps
    end
  end
end

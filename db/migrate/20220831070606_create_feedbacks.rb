class CreateFeedbacks < ActiveRecord::Migration[7.0]
  def change
    create_table :feedbacks do |t|
      t.references :owner, null: false
      t.references :feedbackable, polymorphic: true, null: false
      t.text :comment, null: false
      t.timestamps
    end
  end
end

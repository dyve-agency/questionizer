class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.integer :list_id
      t.text :body
      t.text :reply

      t.timestamps
    end
  end
end

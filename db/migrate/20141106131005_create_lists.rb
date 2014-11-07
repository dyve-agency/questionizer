class CreateLists < ActiveRecord::Migration
  def change
    create_table :lists do |t|
      t.string :uuid
      t.text :emails_to_notify

      t.timestamps
    end
  end
end

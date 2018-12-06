class CreateAlarms < ActiveRecord::Migration[5.2]
  def change
    create_table :alarms do |t|
      t.string :name
      t.text :text
      t.integer :upvotes
      t.integer :downvotes

      t.timestamps
    end
  end
end

class CreateNewLines < ActiveRecord::Migration
  def change
    create_table :new_lines do |t|
      t.integer :vote
      t.text :content
      t.integer :story_id
      t.string :author

      t.timestamps
    end
  end
end

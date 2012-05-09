class CreateLines < ActiveRecord::Migration
  def change
    create_table :lines do |t|
      t.text :content
      t.string :author
      t.integer :story_id

      t.timestamps
    end
  end
end

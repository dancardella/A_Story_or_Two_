class CreateNewStories < ActiveRecord::Migration
  def change
    create_table :new_stories do |t|
      t.string :title
      t.text :content

      t.timestamps
    end
  end
end

class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :name
      t.integer :posts_count, null: false,default: 0
      t.timestamps null: false
    end
  end
end

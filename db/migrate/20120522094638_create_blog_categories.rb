class CreateBlogCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :blog_categories do |t|
      t.references :user, :null=>false
      t.string :title, :null=>false, :limit=>60
      t.integer :blogs_count, :null=>false, :default=>0
      t.boolean :enable, :null=>false, :default=>true
      t.timestamps null: false
    end

    add_index :blog_categories, :title,  :unique => true
  end
end

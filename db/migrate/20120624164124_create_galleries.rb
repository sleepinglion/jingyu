class CreateGalleries < ActiveRecord::Migration[6.0]
  def change
    create_table :gallery_categories do |t|
      t.references :gallery_category
      t.string :title, :null=>false, :limit=>60,  :unique => true
      t.integer :galleries_count, :null=>false, :default=>0
      t.integer :gallery_categories_count, :null=>false, :default=>0
      t.boolean :leaf, :default=>true
      t.boolean :enable, :null=>false, :default=>true
      t.timestamps null: false
    end

    create_table :galleries do |t|
      t.references :gallery_category,:null=>false
      t.string :title, :null=>false, :limit=>60
      t.string :location, :limit=>255
      t.string :photo,:null=>false
      t.string :content, :null=>false, :limit=>255
      t.boolean :enable, :null=>false, :default=>true
      t.timestamps null: false
    end
  end
end

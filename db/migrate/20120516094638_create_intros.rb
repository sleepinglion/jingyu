class CreateIntros < ActiveRecord::Migration[6.0]
  def change
    create_table :intros do |t|
      t.references :user, :null=>false      
      t.string :title, :null=>false, :limit=>60
      t.string :alternate_name, :limit=>60
      t.boolean :gender, :default=>true
      t.date :birth_date
      t.date :death_date
      t.integer :height
      t.integer :weight
      t.string :url
      t.string :job_title, :limit=>60
      t.integer :user_photos_count,:default=>0,:null=>false
      t.boolean :enable, :null=>false, :default=>true            
      t.timestamps :null=>false
    end
    
    create_table :intro_photos do |t|
      t.references :intro, :null=>false
      t.string :photo, :null=>false
      t.string :alt,:limit=>60, :null=>false
      t.boolean :default, :null=>false, :default=>0
      t.boolean :enable, :null=>false, :default=>1
      t.timestamps :null=>false
    end
    
    create_table :intro_like_n_hates do |t|
      t.references :intro, :null=>false
      t.string :title,:limit=>60, :null=>false
      t.boolean :hate, :null=>false, :default=>0           
      t.boolean :enable, :null=>false, :default=>1
      t.timestamps null: false
    end
  end
end

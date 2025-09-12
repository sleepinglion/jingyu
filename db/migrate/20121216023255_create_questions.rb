class CreateQuestions < ActiveRecord::Migration[6.0]
  def change
    create_table :questions do |t|
      t.references :user
      t.string :title, :limit=>60, :null=>false
      t.boolean :secret, :default=>0, :null=>false
      t.integer :count, :null=>false, :default=>0      
      t.boolean :enable, :null=>false, :default=>true
      t.timestamps null: false
    end
  end  
end

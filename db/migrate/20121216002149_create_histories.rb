class CreateHistories < ActiveRecord::Migration[6.0]
  def change
    create_table :histories do |t|
      t.references :user, :null=>false
      t.string :year, :limit=>40, :null=>false
      t.string :month, :limit=>40
      t.string :title, :limit=>60, :null=>false
      t.text :content, :null=>false
      t.timestamps null: false
    end
  end
end

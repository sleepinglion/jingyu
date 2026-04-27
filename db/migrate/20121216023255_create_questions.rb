class CreateQuestions < ActiveRecord::Migration[6.0]
  def change
    create_table :questions do |t|
      t.references :user
      t.string :title, limit: 60, null: false
      t.boolean :secret, default: false, null: false
      t.integer :count, null: false, default: 100
      t.boolean :enable, null: false, default: true
      t.timestamps null: false
    end
  end  
end

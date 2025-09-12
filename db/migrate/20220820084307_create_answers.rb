class CreateAnswers < ActiveRecord::Migration[6.0]
  def change
    create_table :answers do |t|
      t.references :question, null: false
      t.references :user, null: false
      t.boolean :accepted, null: false, default: false
      t.boolean :enable, null: false, default: true
      t.timestamps null: false
    end
  end
end

class CreateDeviseToUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      ## Database authenticatable
      t.string :email,  :null => false, :limit=>100
      t.string :nickname, :null => false, :limit=>60
      t.string :photo, :null=>true, :limit=>100
      t.string :encrypted_password, :null => false, :limit=>100
      t.string :description, :limit=>150
      t.string :alternate_name, :limit=>100
      t.string :name, :limit=>60
      t.boolean :gender, :default=>false
      t.datetime :birth_date
      t.string :job, :limit=>60
      t.string :url, :limit=>150

      ## Recoverable
      t.string   :reset_password_token, :limit=>150
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      t.integer  :sign_in_count, :default => 0
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip

      ## Confirmable
      # t.string   :confirmation_token
      # t.datetime :confirmed_at
      # t.datetime :confirmation_sent_at
      # t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      # t.integer  :failed_attempts, :default => 0 # Only if lock strategy is :failed_attempts
      # t.string   :unlock_token # Only if unlock strategy is :email or :both
      # t.datetime :locked_at

      ## Token authenticatable
      # t.string :authentication_token
      t.boolean :admin, :null=>false, :default => false
      t.boolean :enable, :null=>false, :default=>true
      t.timestamps null: false
    # Uncomment below if timestamps were not included in your original model.
    # t.timestamps
    end

    add_index :users, :email,                :unique => true
    add_index :users, :reset_password_token, :unique => true
  # add_index :users, :confirmation_token,   :unique => true
  # add_index :users, :unlock_token,         :unique => true
  # add_index :users, :authentication_token, :unique => true
  end
end

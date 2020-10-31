# frozen_string_literal: true

class DeviseCreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      ## Database authenticatable
      t.string :email,              null: false, default: ""
      t.string :encrypted_password, null: false, default: ""

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      t.string :authentication_token, null: false
      t.string :user_name
      t.date   :date_of_birth
      t.column :gender, "char(1)", null: :false
      t.string :phone_number 

      t.timestamps null: false
      t.references :role, index: true
    end

    add_index :users, :email,                unique: true
    add_index :users, :reset_password_token, unique: true
    add_index :users, :authentication_token, unique: true
  end
end

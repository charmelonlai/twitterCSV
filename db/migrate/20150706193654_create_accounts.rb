class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :username
      t.string :name
      t.string :password
      t.string :email
      t.string :org
      t.string :bio
      t.string :location
      t.string :website
      t.string :profile_img
      t.string :header_img

      t.timestamps null: false
    end
  end
end

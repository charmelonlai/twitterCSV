class AddSecretToAccounts < ActiveRecord::Migration
  def change
    add_column :accounts, :secret, :string
  end
end

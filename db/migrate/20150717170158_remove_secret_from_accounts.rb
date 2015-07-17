class RemoveSecretFromAccounts < ActiveRecord::Migration
  def change
    remove_column :accounts, :secret, :string
  end
end

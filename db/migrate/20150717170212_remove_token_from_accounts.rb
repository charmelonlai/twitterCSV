class RemoveTokenFromAccounts < ActiveRecord::Migration
  def change
    remove_column :accounts, :token, :string
  end
end

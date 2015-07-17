class RemoveProviderFromAccounts < ActiveRecord::Migration
  def change
    remove_column :accounts, :provider, :string
  end
end

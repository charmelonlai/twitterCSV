class AddProviderToAccounts < ActiveRecord::Migration
  def change
    add_column :accounts, :provider, :string
  end
end

class AddIpaddressToAccounts < ActiveRecord::Migration
  def change
    add_column :accounts, :ipaddress, :string
  end
end

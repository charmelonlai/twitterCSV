class RemoveUidFromAccounts < ActiveRecord::Migration
  def change
    remove_column :accounts, :uid, :string
  end
end

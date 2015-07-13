class AddDummyToAccounts < ActiveRecord::Migration
  def change
    add_column :accounts, :dummy, :string
  end
end

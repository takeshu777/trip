class AddPrivateToUsers < ActiveRecord::Migration
  def change
    add_column :users, :address_pref, :string
    add_column :users, :address_details, :string
    add_column :users, :tel, :string
  end
end

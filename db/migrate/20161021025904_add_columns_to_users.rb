class AddColumnsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :avatar, :string
    add_column :users, :f_name, :string
    add_column :users, :l_name, :string
    add_column :users, :profile, :text
    add_column :users, :gender, :integer
    add_column :users, :birthday, :date
  end
end

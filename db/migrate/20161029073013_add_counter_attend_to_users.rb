class AddCounterAttendToUsers < ActiveRecord::Migration
  def change
    add_column :users, :attends_count, :integer, :default => 0
  end
end

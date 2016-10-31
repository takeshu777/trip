class AddCounterToEvents < ActiveRecord::Migration
  def change
    add_column :events, :favorites_count, :integer, :default => 0
    add_column :events, :attends_count, :integer, :default => 0
  end
end

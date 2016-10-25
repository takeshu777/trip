class AddColumnsToEvents < ActiveRecord::Migration
  def change
    add_column :events, :apply_start_date, :date
    add_column :events, :apply_end_date, :date
  end
end

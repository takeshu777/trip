class ChangeClassToPlaces < ActiveRecord::Migration
  def change
		rename_column :places, :class, :kind
  end
end

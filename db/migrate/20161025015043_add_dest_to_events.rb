class AddDestToEvents < ActiveRecord::Migration
  def change
    add_column :events, :dest, :string
  end
end

class ChangePriceToEvents < ActiveRecord::Migration
  def change
    change_column :events, :price, :integer ,default: 0
  end
end

class CreateAttends < ActiveRecord::Migration
  def change
    create_table :attends do |t|
      t.references :event
      t.references :user
      t.text :comment
      t.timestamps
    end
  end
end

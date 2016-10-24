class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
      t.date :start_date
      t.date :end_date
      t.text :summary
      t.text :details
      t.integer :status
      t.references :user
      t.timestamps
    end
  end
end

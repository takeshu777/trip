class CreateDetailsImages < ActiveRecord::Migration
  def change
    create_table :details_images do |t|
      t.references :event
      t.string :photo
      t.timestamps
    end
  end
end

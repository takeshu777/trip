class CreatePlaces < ActiveRecord::Migration
  def change
    create_table :places do |t|
    	t.string :name
    	t.string :reading
    	t.string :latitude
    	t.string :longitude
    	t.string :class
    	t.integer :layer
    	t.integer :code
      t.timestamps
    end
  end
end

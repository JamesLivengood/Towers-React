class AddIndexToTowersAndTransmitters < ActiveRecord::Migration[6.0]
  def change
    add_index :towers, :latitude
    add_index :towers, :longitude
    add_index :transmitters, :latitude
    add_index :transmitters, :longitude
  end
end

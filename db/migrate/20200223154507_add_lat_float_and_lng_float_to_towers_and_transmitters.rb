class AddLatFloatAndLngFloatToTowersAndTransmitters < ActiveRecord::Migration[6.0]
  def change
    add_column :towers, :lat_float, :float
    add_column :towers, :lng_float, :float
    add_column :transmitters, :lat_float, :float
    add_column :transmitters, :lng_float, :float
  end
end

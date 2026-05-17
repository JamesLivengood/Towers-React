class AddMockedToTowersAndTransmitters < ActiveRecord::Migration[7.2]
  def change
    add_column :towers, :mocked, :boolean, default: false, null: false
    add_column :transmitters, :mocked, :boolean, default: false, null: false
  end
end

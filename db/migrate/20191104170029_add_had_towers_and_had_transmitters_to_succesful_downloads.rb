class AddHadTowersAndHadTransmittersToSuccesfulDownloads < ActiveRecord::Migration[6.0]
  def change
    add_column :succesful_downloads, :had_towers, :boolean
    add_column :succesful_downloads, :had_transmitters, :boolean
  end
end

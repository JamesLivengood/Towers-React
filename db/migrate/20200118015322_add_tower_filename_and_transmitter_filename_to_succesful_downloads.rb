class AddTowerFilenameAndTransmitterFilenameToSuccesfulDownloads < ActiveRecord::Migration[6.0]
  def change
    add_column :succesful_downloads, :tower_filename, :string
    add_column :succesful_downloads, :transmitter_filename, :string
  end
end

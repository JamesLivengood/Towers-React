class AddReranCountToFailedDownloads < ActiveRecord::Migration[6.0]
  def change
    add_column :failed_downloads, :reran_count, :integer
  end
end

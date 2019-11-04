class AddMarkedIgnoreToFailedDownloads < ActiveRecord::Migration[6.0]
  def change
    add_column :failed_downloads, :marked_ignore, :boolean
  end
end

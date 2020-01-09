class AddErrorToFailedDownloads < ActiveRecord::Migration[6.0]
  def change
    add_column :failed_downloads, :error, :string
  end
end

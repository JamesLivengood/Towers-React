class CreateSuccesfulDownloads < ActiveRecord::Migration[6.0]
  def change
    create_table :succesful_downloads do |t|
      t.float :lat
      t.float :lng
      t.string :url

      t.timestamps
    end
  end
end

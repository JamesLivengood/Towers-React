class CreateBroadcasts < ActiveRecord::Migration[6.0]
  def change
    create_table :broadcasts do |t|
      t.text :tags, array: true, default: []
      t.datetime :send_at
      t.text :markdown_body
      t.string :subject

      t.timestamps
    end
  end
end

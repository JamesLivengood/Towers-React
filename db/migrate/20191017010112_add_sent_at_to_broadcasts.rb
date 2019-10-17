class AddSentAtToBroadcasts < ActiveRecord::Migration[6.0]
  def change
    add_column :broadcasts, :sent_at, :datetime, null: true
  end
end

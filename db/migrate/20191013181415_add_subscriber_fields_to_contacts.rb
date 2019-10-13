class AddSubscriberFieldsToContacts < ActiveRecord::Migration[6.0]
  def change
    add_column :contacts, :tags, :text, array: true, default: [], index: true
    add_column :contacts, :unsubscribe_key, :string, index: true
    add_column :contacts, :unsubscribed_at, :datetime, null: true
    add_column :contacts, :subscribed_at, :datetime, null: true
  end
end

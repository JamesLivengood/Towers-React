class CreateContacts < ActiveRecord::Migration[6.0]
  def change
    create_table :contacts do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.text :description_markdown
      t.string :primary_email, null: false
      t.text :secondary_emails, array: true, default: []
      t.string :phone
      t.datetime :last_proactive_outreach
      t.datetime :last_inbound_message
      t.string :linkedin
      t.string :twitter
      t.string :instagram

      t.timestamps
    end
  end
end

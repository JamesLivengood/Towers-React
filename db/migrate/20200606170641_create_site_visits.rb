class CreateSiteVisits < ActiveRecord::Migration[6.0]
  def change
    create_table :site_visits do |t|
      t.string :ip_address
      t.string :user_agent
      t.string :params
      t.string :browser_string
      t.jsonb :geo_data

      t.timestamps
    end
  end
end

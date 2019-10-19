class CreateTowers < ActiveRecord::Migration[6.0]
  def change
    create_table :towers do |t|
      t.string :tower_type
      t.string :faa_study_number
      t.string :registration_number
      t.string :latitude
      t.string :longitude
      t.string :status_code
      t.string :date_constructed
      t.string :structure_street_address
      t.string :structure_city
      t.string :structure_state_code
      t.string :height_of_structure
      t.string :ground_elevation
      t.string :overall_height_above_ground
      t.string :overall_height_amsl
      t.string :structure_type
      t.string :owner_entity_name
      t.string :owner_licensee_id
      t.string :owner_first_name
      t.string :owner_last_name
      t.string :owner_phone
      t.string :owner_internet_address
      t.string :owner_street_address
      t.string :owner_po_box
      t.string :owner_city
      t.string :owner_state
      t.string :owner_zip_code
      t.string :owner_attention
      t.string :rep_entity_name
      t.string :rep_licensee_id
      t.string :rep_first_name
      t.string :rep_last_name
      t.string :rep_phone
      t.string :rep_internet_address
      t.string :rep_street_address
      t.string :rep_po_box
      t.string :rep_city
      t.string :rep_state
      t.string :rep_zip_code
      t.string :rep_attention
      t.string :hist1_purpose
      t.string :hist1_status
      t.string :hist1_date
      t.string :hist1_addnl
      t.string :hist2_purpose
      t.string :hist2_status
      t.string :hist2_date
      t.string :hist2_addnl
      t.string :hist3_purpose
      t.string :hist3_status
      t.string :hist3_date
      t.string :hist3_addnl

      t.timestamps
    end
  end
end

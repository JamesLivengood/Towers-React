class CreateTransmitters < ActiveRecord::Migration[6.0]
  def change
    create_table :transmitters do |t|
      t.string :sitetype
      t.string :sitenum
      t.string :latitude
      t.string :longitude
      t.string :call_sign
      t.string :location_address
      t.string :location_city
      t.string :location_county
      t.string :location_state
      t.string :ground_elevation
      t.string :height_of_support_structure
      t.string :overall_height_of_structure
      t.string :structure_type
      t.string :licensee_entity_name
      t.string :licensee_first_name
      t.string :licensee_last_name
      t.string :licensee_phone
      t.string :licensee_fax
      t.string :licensee_email
      t.string :licensee_street_address
      t.string :licensee_city
      t.string :licensee_state
      t.string :licensee_zip_code
      t.string :licensee_po_box
      t.string :licensee_attention_line
      t.string :contact_entity_name
      t.string :contact_first_name
      t.string :contact_last_name
      t.string :contact_phone
      t.string :contact_fax
      t.string :contact_email
      t.string :contact_street_address
      t.string :contact_city
      t.string :contact_state
      t.string :contact_zip_code
      t.string :contact_po_box
      t.string :contact_attention_line
      t.string :emmitter_1_freqs_mhz
      t.string :emmitter_2_freqs_mhz
      t.string :emmitter_3_freqs_mhz
      t.string :emmitter_4_freqs_mhz
      t.string :emmitter_5_freqs_mhz

      t.timestamps
    end
  end
end

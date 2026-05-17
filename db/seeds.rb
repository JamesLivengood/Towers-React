CELL_MILES = 15.0
MILES_PER_LAT_DEG = 69.0

# Contiguous US bounding box
LAT_MIN, LAT_MAX = 24.5, 49.5
LNG_MIN, LNG_MAX = -124.8, -66.9

lat_step = CELL_MILES / MILES_PER_LAT_DEG
total_cells = 0
seeded_cells = 0

puts "Pre-loading existing tower coordinates for fast lookup..."
existing = Tower.pluck(:latitude, :longitude)
  .map { |lat, lng| [lat.to_f.round(2), lng.to_f.round(2)] }
  .to_set

puts "Found #{existing.size} existing tower locations."
puts "Seeding random towers/transmitters across the US (skipping areas with existing data)..."

lat = LAT_MIN
while lat < LAT_MAX
  lng_step = CELL_MILES / (MILES_PER_LAT_DEG * Math.cos(lat * Math::PI / 180))
  lng = LNG_MIN
  while lng < LNG_MAX
    total_cells += 1
    cell_key = [lat.round(2), lng.round(2)]

    unless existing.include?(cell_key)
      seeded_cells += 1
      rand(0..2).times do
        Tower.create!(
          latitude:  (lat  + rand * lat_step).round(6).to_s,
          longitude: (lng  + rand * lng_step).round(6).to_s,
          tower_type: ["Registered", "Unregistered"].sample,
          registration_number: "SEED#{SecureRandom.hex(6)}",
          height_of_structure: rand(50..500).to_s,
          structure_state_code: "US",
          status_code: "Constructed",
          mocked: true
        )
      end

      rand(0..5).times do
        Transmitter.create!(
          latitude:  (lat  + rand * lat_step).round(6).to_s,
          longitude: (lng  + rand * lng_step).round(6).to_s,
          sitetype: ["Single", "Multiple"].sample,
          sitenum: "SEED#{rand(100000..999999)}",
          mocked: true
        )
      end
    end

    if total_cells % 500 == 0
      puts "  #{total_cells} cells checked, #{seeded_cells} seeded..."
      $stdout.flush
    end

    lng += lng_step
  end
  lat += lat_step
end

puts "Done! Checked #{total_cells} cells, seeded #{seeded_cells} new areas."
puts "Total towers: #{Tower.count}, transmitters: #{Transmitter.count}"

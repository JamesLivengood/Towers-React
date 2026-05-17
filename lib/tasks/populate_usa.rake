namespace :populate do
  desc 'Scan the entire contiguous United States and populate towers/transmitters'
  task :usa => :environment do
    # Contiguous US bounding box
    # Bottom-left (SW): lat 24.396308, lng -66.885444  (southernmost Florida / easternmost Maine)
    # AreaPopulator starts at bottom-right and moves LEFT (west), then UP (north)
    # So starting point is bottom-RIGHT corner: lat 24.396308, lng -66.885444
    # Width (east→west): ~2,800 miles
    # Height (south→north): ~1,700 miles

    start_lat = 24.396308   # Southern tip of Florida
    start_lng = -66.885444  # Easternmost point (Maine coast)
    width_miles  = 2_800    # How far west to scan
    height_miles = 1_700    # How far north to scan

    # Optional: resume from a midway point if interrupted.
    # Set these to the last-logged lat/lng to skip already-fetched areas.
    resume_lat = ENV['RESUME_LAT']&.to_f || start_lat
    resume_lng = ENV['RESUME_LNG']&.to_f || start_lng

    puts "Starting US population scan"
    puts "  Origin (bottom-right):  #{start_lat}, #{start_lng}"
    puts "  Resume point:           #{resume_lat}, #{resume_lng}"
    puts "  Width: #{width_miles} miles west  |  Height: #{height_miles} miles north"
    puts "  Estimated steps: ~#{((width_miles / (AreaPopulator::MOVE_DISTANCE)) * (height_miles / (AreaPopulator::MOVE_DISTANCE))).to_i}"
    puts ""

    populator = AreaPopulator.new(
      start_lat,
      start_lng,
      width_miles,
      height_miles,
      resume_lat,
      resume_lng
    )

    populator.populate!

    puts "Done! US scan complete."
  end
end

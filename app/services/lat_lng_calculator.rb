class LatLngCalculator
  # Distances are measured in miles.
  # Longitudes and latitudes are measured in degrees.
  # Earth is assumed to be perfectly spherical.
  EARTH_RADIUS = 3960.0
  DEGREES_TO_RADIANS = Math::PI/180.0
  RADIANS_TO_DEGREES = 180.0/Math::PI

  # Given a distance north, returns the change in latitude
  def change_in_latitude(miles)
    (miles/EARTH_RADIUS)*RADIANS_TO_DEGREES
  end

  # Finds the radius of a circle around the earth at given latitude
  # Given a latitude and a distance west, return the change in longitude
  def change_in_longitude(latitude, miles)
    r = EARTH_RADIUS*Math.cos(latitude*DEGREES_TO_RADIANS)
    return (miles/r)*RADIANS_TO_DEGREES
  end
end
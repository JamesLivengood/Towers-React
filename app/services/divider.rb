class Divider
    attr_reader :lat, :lng, :width, :height, :calc, :split_number
    def initialize(lat, lng, width, height, split_number)
        @lat = lat
        @lng = lng
        @width = width
        @height = height
        @split_number = split_number
        @calc = LatLngCalculator.new
    end 

    def divide!
        arr = []
        (split_number).times do |idx|
            temp_lat = lat + calc.change_in_latitude(populator_height * idx)
            arr << "AreaPopulator.new(#{temp_lat}, #{lng}, #{width}, #{populator_height}).populate!"
        end 
        arr
    end 

    private

    def populator_height
        @_ph ||= height / split_number
    end 
end 
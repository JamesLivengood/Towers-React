require 'test_helper'
class LatLngCalculatorTest < ActiveSupport::TestCase
  let!(:calculator) { LatLngCalculator.new }

  describe "#change_in_latitude" do
    describe "up 1.5 miles" do
      let!(:lat) { rand(-90.0..90.0) }
      it 'calculates correctly' do
        assert_equal 0.014468631190172304, calculator.change_in_latitude(1)
      end
    end
  end
end
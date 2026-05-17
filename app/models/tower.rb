class Tower < ApplicationRecord
  validates :registration_number, uniqueness: true, allow_blank: true

  def self.write_all_to_csv(filename = "latest_towers.csv")
    CSV.open(filename, "wb") do |csv|
      csv << Tower.attribute_names
      Tower.find_each do |tower|
        csv << tower.attributes.values
      end
    end
  end
end

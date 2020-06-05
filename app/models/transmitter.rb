class Transmitter < ApplicationRecord
  validate :ensure_unique

  def ensure_unique
    errors.add(:base, 'This exact transmitter already exists!') if Transmitter.where(self.attributes.without(["id", "created_at", "updated_at"])).present?
  end

  def self.write_all_to_csv(filename = "latest_transmitters.csv")
    CSV.open(filename, "wb") do |csv|
      csv << Transmitter.attribute_names
      Transmitter.find_each do |transmitter|
        csv << transmitter.attributes.values
      end
    end
  end
end

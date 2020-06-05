class Tower < ApplicationRecord
  validate :ensure_unique

  def ensure_unique
    errors.add(:base, 'This exact tower already exists!') if Tower.where(self.attributes.without(["id", "created_at", "updated_at"])).present?
  end

  def self.write_all_to_csv(filename = "latest_towers.csv")
    CSV.open(filename, "wb") do |csv|
      csv << Tower.attribute_names
      Tower.find_each do |tower|
        csv << tower.attributes.values
      end
    end
  end
end

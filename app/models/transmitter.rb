class Transmitter < ApplicationRecord
  validate :ensure_unique

  def ensure_unique
    errors.add(:base, 'This exact transmitter already exists!') if Transmitter.where(self.attributes.without(["id", "created_at", "updated_at"])).present?
  end
end

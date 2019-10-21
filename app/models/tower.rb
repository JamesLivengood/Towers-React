class Tower < ApplicationRecord
  validate :ensure_unique

  def ensure_unique
    errors.add(:base, 'This exact tower already exists!') if Tower.where(self.attributes.without(["id", "created_at", "updated_at"])).present?
  end
end

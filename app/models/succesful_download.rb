class SuccesfulDownload < ApplicationRecord
  validate :ensure_unique

  def ensure_unique
    errors.add(:base, 'This exact successful download already exists') if SuccesfulDownload.where(self.attributes.without(["id", "created_at", "updated_at"])).present?
  end
end

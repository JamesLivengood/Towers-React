class FailedDownload < ApplicationRecord
  scope :still_failed, -> { where(reran_successfully: nil) }

  validate :ensure_unique

  def ensure_unique
    errors.add(:base, 'This exact failed download already exists') if FailedDownload.where(self.attributes.without(["id", "created_at", "updated_at"])).present?
  end

  def mark!
    update(marked_ignore: true)
  end
end

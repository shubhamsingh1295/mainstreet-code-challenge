class Company < ApplicationRecord
  self.per_page = 7
  EMAIL_REGEX = /\A[a-zA-Z0-9_.+-]+@(?:(?:[a-zA-Z0-9-]+\.)?[a-zA-Z]+\.)?(getmainstreet)\.com\z/.freeze
  has_rich_text :description
  validates :email, allow_blank: true, format: { with: EMAIL_REGEX }
  validates :phone, allow_blank: true, numericality: true, length: {
    minimum: 10, maximum: 10
  }
  validates :name, :zip_code, presence: true
  validate :validate_zip_code

  before_save :upsert_city_state, if: :zip_code_changed?

  def full_address
    "#{city}, #{state}"
  end

  private

  def validate_zip_code
    unless ZipCodes.identify(zip_code)
      errors.add :zip_code, 'is invalid'
      return false
    end
    true
  end

  def upsert_city_state
    hash = ZipCodes.identify(zip_code)
    self.city = hash.dig(:city)
    self.state = hash.dig(:state_code)
  end
end

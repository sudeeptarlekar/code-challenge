class Company < ApplicationRecord
  MAIL_REGEX = /\A[a-zA-Z0-9.!\#$%&'*+\/=?^_`{|}~-]+@getmainstreet\.com/

  has_rich_text :description

  validate :email_address_validator, :zip_code_for_company
  before_save :update_state_and_city_from_zip_code

  private

  def email_address_validator
    return true if email.nil?

    errors.add(:email, 'address entered is not valid') unless email.match?(MAIL_REGEX)
  end

  def zip_code_for_company
    return true if zip_code.nil?

    errors.add(:zip_code, 'is invalid') unless ZipCodes.identify(zip_code)
  end

  def update_state_and_city_from_zip_code
    return if zip_code.nil?

    address = ZipCodes.identify(zip_code) || {}
    self.state_name = address[:state_name]
    self.city = address[:city]
  end
end

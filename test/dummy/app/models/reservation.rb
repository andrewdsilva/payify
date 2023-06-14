class Reservation < ApplicationRecord
  include ::Payify::HasPaymentConcern

  def amount_to_pay
    price
  end
end

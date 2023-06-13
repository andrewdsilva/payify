class Reservation < ApplicationRecord
  include ::Payify::HasPaymentConcern

  def ammount_to_pay
    price
  end
end

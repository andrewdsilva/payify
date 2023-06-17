Reservation.delete_all
Payify::Payment.delete_all

# Creating a reservation with a payment with id 1 for testing

reservation_1 = Reservation.create!(id: 1, price: 1500)
reservation_1.create_payment
reservation_1.payment.id = 1
reservation_1.payment.save!
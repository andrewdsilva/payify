class CreateReservation < ActiveRecord::Migration[7.0]
  def change
    create_table :reservations do |t|
      t.decimal :price

      t.timestamps
    end
  end
end

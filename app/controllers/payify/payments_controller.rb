module Payify
  class PaymentsController < ActionController::Base
    before_action :set_object, only: %i[new create]

    def new
      @payment.stripe_init_intent

      respond_to do |format|
        format.html
        format.json { render json: @payment }
      end
    end

    def create
      @payment.stripe_confirm_payment(payment_params)

      respond_to do |format|
        format.html
        format.json { render json: @payment }
      end
    end

    private

    def set_object
      @payment = Payment.find(params[:id])
    end

    def payment_params
      params.require(:payment).permit(:stripe_payment_id)
    end
  end
end

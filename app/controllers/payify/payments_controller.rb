module Payify
  class PaymentsController < ActionController::Base
    before_action :set_object, only: %i[new complete]

    def new
      @payment.stripe_init_intent

      respond_to do |format|
        format.html
        format.json { render json: @payment }
      end
    end

    def complete
      @payment.stripe_confirm_payment unless @payment.paid?

      respond_to do |format|
        format.html
        format.json { render json: @payment }
      end
    end

    private

    def set_object
      @payment = Payment.find(params[:id])
    end
  end
end

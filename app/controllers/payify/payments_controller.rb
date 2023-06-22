module Payify
  class PaymentsController < ActionController::Base
    include ::Payify::PaymentsControllerConcern
  end
end

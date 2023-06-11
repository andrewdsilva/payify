# Payify

PayifyRails is a Ruby gem that simplifies payment integration into Ruby on Rails projects. It allows to easily add payment functionality to your models. For example, by applying the HasPaymentConcern to a reservation model, you can manage the payment process for reservations seamlessly.

## Status 🚧

This gem is under construction. Stay tuned for exciting updates as I continue to shape it.

## Installation

To install the gem add it into a Gemfile (Bundler):

```ruby
gem 'payify', git: 'https://github.com/andrewdsilva/payify'
```

And then execute:

```
bundle install
```

## Features ✅

- Includes a Payment model
- Provides concerns to easily add a payment system to your model
- Allows configuration of payment modes (initially supports Stripe)
- Provides a user interface for payment processing
- Enables management of payment status (pending, paid)

## Configuration

By default, Payify uses Stripe as the payment gateway. You can configure your Stripe API credentials in your Rails application's configuration file (config/application.rb or config/environments/*.rb).

```ruby
# config/application.rb
config.payify.stripe_api_key = 'YOUR_STRIPE_API_KEY'
config.payify.currency = 'usd'
config.payify.default_tax_rates_id = 'txr_1234567890'
```

To handle VAT or different tax rates on your payments, you need to create tax rates on Stripe and define the default_tax_rates_id or, alternatively, define the tax_rates_id method on your payment-related models. Leave it empty if you don't manage any taxes.

## Usage

To enable payment functionality for a model, simply include the HasPayment concern:

```ruby
class Reservation < ApplicationRecord
  include Payify::HasPaymentConcern

  def ammount_to_pay
    self.price
  end

  # Optional : Override the default tax rates id
  def tax_rates_id
    'txr_1234567890'
  end
end
```

## Tests

To run the tests, execute `rspec` command.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/andrewdsilva/payify.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

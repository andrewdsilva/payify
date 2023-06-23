# Payify

<span>[![Gem Version](https://img.shields.io/gem/v/payify.svg?label=payify&colorA=D30001&colorB=DF3B3C)](https://rubygems.org/gems/payify)</span> <span>
[![ruby](https://img.shields.io/badge/ruby-7.0+%20*-ruby.svg?colorA=D30001&colorB=DF3B3C)](https://github.com/andrewdsilva/payify)</span> <span>
![Rubocop Status](https://img.shields.io/badge/rubocop-passing-rubocop.svg?colorA=1f7a1f&colorB=2aa22a)</span> <span>
[![MIT license](https://img.shields.io/badge/license-MIT-mit.svg?colorA=1f7a1f&colorB=2aa22a)](http://opensource.org/licenses/MIT)</span> <span>
![Downloads](https://img.shields.io/gem/dt/payify.svg?colorA=004d99&colorB=0073e6)</span>

PayifyRails is a Ruby gem that simplifies payment integration into Ruby on Rails projects. It allows to easily add payment functionality to your models. For example, by applying the HasPaymentConcern to a reservation model, you can manage the payment process for reservations seamlessly.

![Screenshot](./app/assets/images/payify/screenshot.png)

## Installation

To install the gem add it into a Gemfile (Bundler):

```ruby
gem 'payify', '~> 0.1.0'
```

And then execute:

```
bundle install

rails payify_engine:install:migrations
```

## Features ✅

- Easily create a payment using your models (e.g., from a reservation)
- Set up payment with Stripe in just 2 minutes
- Add a payment form to an existing page in your application
- You can configure the currency and tax rates (VAT)
- You can track the status of your payments (pending, paid)
- You can check the payment status through the API

## Configuration

You can configure the currency using an initializer.

```ruby
# initializers/payify.rb
Payify.setup do |config|
  config.currency = "usd"
  config.default_tax_rates_id = "txr_1234567890"
end
```

### Tax rates

To handle VAT or different tax rates on your payments, you need to create tax rates on Stripe and define the default_tax_rates_id or, alternatively, define the tax_rates_id method on your payment-related models. Leave it empty if you don't manage any taxes.

To create a tax rate on Stripe, follow these steps:

1. Go to the "Products" menu in your Stripe account.
2. Navigate to the "Tax Rates" tab.
3. Click on the "New" button located at the top right corner.

### API key

You need to set your Stripe API credentials using environment variables. (Secret key, Publishable key)

```ruby
# .env
STRIPE_API_KEY="..."
STRIPE_PUBLISHABLE_KEY="..."
```

## Usage

### Add the functionality to your model

To enable payment functionality for a model, simply include the HasPayment concern:

```ruby
class Reservation < ApplicationRecord
  include ::Payify::HasPaymentConcern

  def amount_to_pay
    self.price
  end

  # Optional : Override the default tax rates id
  def tax_rates_id
    'txr_1234567890'
  end
end
```

### Create a payment

When you want to request a payment for a model on which you added the concern, you just need to call the create_payment method.

Then you can find the id of the new pending payment with payment.id.

```ruby
reservation_1.create_payment
reservation_1.payment.id # new payment id
```

You can use the `after_save` event on your model to automatically create the payment. Here's an example of how you can implement it:

```ruby
class Booking < ApplicationRecord
  include ::Payify::HasPaymentConcern

  after_save :create_payment

  def amount_to_pay
    total_ttc
  end
end
```

### Include the routes

To be able to use the routes of Payify, you need to add the following line to your `config/routes.rb` file:

```ruby
mount Payify::Engine => '/payify', as: 'payify'
```

### Request a payment

To allow the user to make a payment, you have two options:

1. Redirect the user to the payment form: You can redirect the user to the payment form using the URL `/payify/payments/:id/new`, where `:id` represents the payment id.

2. Include the payment form on your page:

```ruby
# reservation/show.html.erb
<%= render "payify/payments/form", payment: @object.payment %>
```

After completing the payment process, the user will be redirected to:

```
/payments/:id/complete
```

### Verify the payment

The application will then verify the payment status with Stripe. You can do it manually calling the following method:

```ruby
@payment.stripe_confirm_payment
```

If the payment has been successfully processed, a confirmation message will be displayed to the user. The payment method `paid?` will return `true`.

To customize the page that displays the payment status, you can create the following file:

```ruby
# views/payify/payments/complete.html.erb

<% if @payment.paid? %>
  <div class="alert alert-success" role="alert">
    <%= I18n.t("payments.complete.paid") %>
  </div>
<% else %>
  <div class="alert alert-danger" role="alert">
    <%= I18n.t("payments.complete.pending") %>
  </div>
<% end %>
```

### Override the controller

If you want to override the `PaymentsController`, create the following file:

```ruby
# app/controllers/payify/payments_controller.rb
module Payify
  class PaymentsController < ApplicationController
    include ::Payify::PaymentsControllerConcern

    ...
  end
end
```

### Using the API

If you prefer using the Payify API, after creating the payment object, you can initialize a new Stripe payment by making a request to: `/payments/:id/new.json`

This request will return a JSON response containing the `stripe_payment_intent_id` and `stripe_client_secret` required to process a payment using Stripe.

After making the payment, you can make a request to the following endpoint to update the payment status and retrieve its current state:

```
/payments/:id/complete.json
```

### Status

You can access the payment status using `@payment.status`. The possible statuses are:

- `pending`: The payment is still being processed.
- `paid`: The payment has been successfully completed.
- `failed`: The payment has failed.

## Tests

To run the tests, execute `rspec` command.

You can test the payment process in your web browser by following these steps:

1. Navigate to the `test/dummy` directory.
2. Run the following commands:
   - `rails db:create`
   - `rails db:migrate`
   - `rails db:seed`
   - `rails s`
3. Open your browser and go to: [http://localhost:3000/](http://localhost:3000/).

Each time you run the seed command, your test database will be reset with a reservation that has a payment with an ID of 1. This allows you to test the payment process at the following address: [http://localhost:3000/payments/1/new](http://localhost:3000/payments/1/new).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/andrewdsilva/payify.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

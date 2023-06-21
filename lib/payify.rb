# frozen_string_literal: true

require_relative "payify/version"
require "payify/engine"
require "dotenv/load"

module Payify
  class Error < StandardError; end

  mattr_accessor :currency
  @@currency = "usd"

  mattr_accessor :default_tax_rates_id
  @@default_tax_rates_id = nil

  mattr_accessor :stripe_api_key
  @@stripe_api_key = ENV["STRIPE_API_KEY"]

  mattr_accessor :stripe_publishable_key
  @@stripe_publishable_key = ENV["STRIPE_PUBLISHABLE_KEY"]

  def self.setup
    yield self
  end
end

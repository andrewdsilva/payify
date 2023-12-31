# frozen_string_literal: true

require_relative "lib/payify/version"

Gem::Specification.new do |spec|
  spec.name = "payify"
  spec.version = Payify::VERSION
  spec.authors = ["Nathan Lopez"]
  spec.email = ["nathan.lopez042@gmail.com"]

  spec.summary = "Payment integration for Ruby on Rails projects."
  spec.description = "Payify is a Ruby gem that simplifies payment integration into Ruby on Rails projects."
  spec.homepage = "https://github.com/andrewdsilva/payify"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.files = Dir["{app,config,lib,db}/**/*", "MIT-LICENSE", "README.md"]

  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "active_model_serializers", "~> 0.10.13"
  spec.add_dependency "dotenv-rails", "~> 2.8.1"
  spec.add_dependency "money", "~> 6.16"
  spec.add_dependency "rails", "~> 7.0"
  spec.add_dependency "stripe", "~> 8.5.0"
end

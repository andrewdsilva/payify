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

  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) || f.start_with?(*%w[bin/ test/ spec/ features/ .git .circleci appveyor])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "rails", ">= 7.0"
end

# frozen_string_literal: true

source "https://rubygems.org"

gemspec name: "elelem-openrouter"

# Until elelem-openai's next release, use a checkout next to this one when there is one.
openai = File.expand_path("../openai", __dir__)
gem "elelem-openai", path: openai if File.directory?(openai)

gem "irb"
gem "rake", "~> 13.0"
gem "rspec", "~> 3.0"
gem "rubocop", "~> 1.79", require: false

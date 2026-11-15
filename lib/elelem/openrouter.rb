# frozen_string_literal: true

require "elelem/openai"

require_relative "openrouter/version"

Elelem.configure do |config|
  config.provider(:openrouter) do |model: nil, **|
    # A variable that is set but empty counts as unset.
    env = ->(name) { ENV[name].to_s.strip.then { |v| v.empty? ? nil : v } }
    key = env.call("OPENROUTER_API_KEY")
    raise KeyError, "OPENROUTER_API_KEY is not set" if key.nil?

    model = env.call("OPENROUTER_MODEL") if model.to_s.strip.empty?
    raise KeyError, "OPENROUTER_MODEL is not set. Pass --model or set OPENROUTER_MODEL" if model.nil?

    Elelem::OpenAI::Provider.new(
      model:,
      api_key: key,
      base_url: env.call("OPENROUTER_BASE_URL") || "https://openrouter.ai/api/v1"
    )
  end
end

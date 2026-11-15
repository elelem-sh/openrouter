# frozen_string_literal: true

RSpec.describe "the openrouter provider" do
  around do |example|
    saved = ENV.to_h.slice("OPENROUTER_API_KEY", "OPENROUTER_BASE_URL", "OPENROUTER_MODEL")
    example.run
  ensure
    %w[OPENROUTER_API_KEY OPENROUTER_BASE_URL OPENROUTER_MODEL].each { |k| ENV.delete(k) }
    ENV.update(saved)
  end

  before do
    ENV["OPENROUTER_API_KEY"] = "test-key"
    ENV["OPENROUTER_MODEL"] = "env-model"
    ENV.delete("OPENROUTER_BASE_URL")
  end

  def build(**) = Elelem::Config.build_provider("openrouter", **)
  def uri(**) = build(**).instance_variable_get(:@uri).to_s
  def model(**) = build(**).instance_variable_get(:@model)

  it "registers provider openrouter" do
    expect(Elelem::Config.names).to include("openrouter")
    expect(build).to be_a(Elelem::OpenAI::Provider)
  end

  it "talks to OpenRouter by default" do
    expect(uri).to eq("https://openrouter.ai/api/v1/chat/completions")
  end

  it "sends OPENROUTER_API_KEY" do
    expect(build.instance_variable_get(:@api_key)).to eq("test-key")
  end

  it "names OPENROUTER_API_KEY when the key is missing or empty" do
    ENV.delete("OPENROUTER_API_KEY")
    expect { build }.to raise_error(KeyError, /OPENROUTER_API_KEY/)

    ENV["OPENROUTER_API_KEY"] = " "
    expect { build }.to raise_error(KeyError, /OPENROUTER_API_KEY/)
  end

  it "names OPENROUTER_MODEL when no model is set, and treats an empty one as unset" do
    ENV.delete("OPENROUTER_MODEL")
    expect { build }.to raise_error(KeyError, /OPENROUTER_MODEL/)

    ENV["OPENROUTER_MODEL"] = ""
    expect { build }.to raise_error(KeyError, /OPENROUTER_MODEL/)
  end

  it "takes the model from OPENROUTER_MODEL" do
    expect(model).to eq("env-model")
  end

  it "prefers --model over OPENROUTER_MODEL" do
    expect(model(model: "flag-model")).to eq("flag-model")
  end

  it "uses OPENROUTER_BASE_URL, with or without a trailing slash, and treats an empty one as unset" do
    ENV["OPENROUTER_BASE_URL"] = "http://127.0.0.1:8080/v1/"
    expect(uri).to eq("http://127.0.0.1:8080/v1/chat/completions")

    ENV["OPENROUTER_BASE_URL"] = "http://127.0.0.1:8080/v1"
    expect(uri).to eq("http://127.0.0.1:8080/v1/chat/completions")

    ENV["OPENROUTER_BASE_URL"] = ""
    expect(uri).to eq("https://openrouter.ai/api/v1/chat/completions")
  end
end

defmodule PhoenixBakery.MixProject do
  use Mix.Project

  @version "0.2.0"
  @github "https://github.com/hauleth/phoenix_bakery"

  def project do
    [
      app: :phoenix_bakery,
      description: "Better compression for your Phoenix assets.",
      version: @version,
      elixir: "~> 1.11",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      source_url: @github,
      docs: [
        main: "PhoenixBakery",
        source_ref: "v#{@version}",
        groups_for_modules: [
          Compressors: ~r/^PhoenixBakery\./
        ]
      ],
      package: [
        licenses: ~w[MIT],
        links: %{
          "GitHub" => @github
        }
      ]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:phoenix, "~> 1.6"},
      {:brotli, "~> 0.3.0", optional: true},
      {:ezstd, "~> 1.2.1", optional: true},
      {:jason, ">= 0.0.0", only: [:dev, :test]},
      {:ex_doc, ">= 0.0.0", only: [:dev]},
      {:credo, "~> 1.5", only: [:dev]}
    ]
  end
end

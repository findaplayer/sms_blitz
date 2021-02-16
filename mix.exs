defmodule SmsBlitz.Mixfile do
  use Mix.Project

  def project do
    [app: :sms_blitz,
     version: "0.1.1",
     elixir: "~> 1.0",
     description: "Send SMS messages through various different suppliers",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps(Mix.env),
     test_coverage: [tool: ExCoveralls],
     preferred_cli_env: [coveralls: :test, "coveralls.detail": :test, "coveralls.post": :test],
     package: package()]
  end

  def application do
    [applications: [:logger, :httpoison, :poison]]
  end

  defp deps(:test) do
    deps(:all) ++ [{:excoveralls, "~> 0.7"}]
  end

  defp deps(:docs) do
    deps(:all) ++ [
      {:inch_ex, "~> 0.5", only: :docs},
    ]
  end

  defp deps(:dev) do
    deps(:all) ++ [
      {:dialyxir, "~> 0.5"},
      {:ex_doc, "~> 0.16", only: :dev},
      {:earmark, "~> 1.2", only: :dev}
    ]
  end

  defp deps(_), do: [
    {:hackney, "~> 1.8"},
    {:httpoison, "~> 1.4"},
    {:poison, "~> 3.0"}
  ]

  defp package do
    [
      files: ["lib", "mix.exs", "README*", "LICENSE"],
      maintainers: ["John Hamelink <john@johnhamelink.com>"],
      licenses: ["MIT"],
      links: %{
        "Docs" => "https://hexdocs.pm/sms_blitz",
        "GitHub" => "https://github.com/johnhamelink/sms_blitz"
      }
    ]
  end

end

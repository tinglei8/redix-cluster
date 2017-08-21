defmodule RedixCluster.Mixfile do
  use Mix.Project

  def project do
    [app: :redix_cluster,
     version: "0.0.1",
     elixir: "~> 1.1",
     build_embedded: Mix.env in [:prod],
     start_permanent: Mix.env == :prod,
     preferred_cli_env: [espec: :test],
     deps: deps,
     description: description, 
     package: package]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [mod: {RedixCluster, []},
    included_applications: [:crc],
    applications: [:logger, :redix]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [ {:redix, "~> 0.6.0"},
      {:poolboy, "~> 1.5"},
      {:dialyze, "~> 0.2", only: :dev},
      {:dogma, "~> 0.0", only: :dev},
      {:crc, "~> 0.5"},
      {:benchfella, github: "alco/benchfella", only: :bench},
      {:eredis_cluster, github: "adrienmo/eredis_cluster", only: :bench},
      {:espec, github: "antonmi/espec", only: :test},
      {:ex_doc, ">= 0.0.0", only: :dev}, 
    ]
  end

  defp description do 
    "A wrapper for redix to support cluster mode of redis"
  end

  defp package do
     [
       maintainers: ["zhongwencool", "masahiro tokioka", "tinglei8"],
       licenses: ["MIT"],
       links: %{"GitHub" => "https://github.com/tinglei8/redix-cluster.git"}
     ]
  end

end

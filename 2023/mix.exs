defmodule Advent.MixProject do
  use Mix.Project

  def project do
    [
      app: :advent,
      version: "0.1.0",
      elixir: "~> 1.15",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      escript: [main_module: Advent.Main]
    ]
  end

  def application do
    [
      extra_applications: [:logger],
      mod: {Advent.Application, []}
    ]
  end

  defp deps do
    [
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
    ]
  end
end

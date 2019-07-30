defmodule Backend.MixProject do
  use Mix.Project

  def project do
    [
      app: :backend,
      version: "0.1.0",
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      dialyzer: [plt_add_apps: [:mix]]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Backend.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies. Это настройка зависимостей, берётся из hex.pm
  # первая цифра мажорная версия, далее минорная и патч
  defp deps do
    [
      {:ecto_sql, "~> 3.1"},
      {:postgrex, ">= 0.0.0"},
      # {:uuid, ">= 0.0.0"},
      # {:dialyxir, "~> 0.5", only: [:dev], runtime: false}, # поставил эту зависимость, т.к. была ошибка
      # > >= < <= == !=
      # > 0.3.0 < 0.5.0  или or and
      # https://hexdocs.pm/elixir/Version.html описание работы с версиями эликсира
      # {:name, requiment, opts}
      # {:test_lib, "~> 1.0", only: [:test]}
      # {:name, git:.uri}
      # {:name, path: ../library, only: [:dev]}
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
    ]
  end
end

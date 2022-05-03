defmodule RitoPls.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application
  alias RitoPls.Runtime.GamesSupervisor

  @impl true
  def start(_type, _args) do
    children = [
      # Starts a worker by calling: RitoPls.Worker.start_link(arg)
      # {RitoPls.Worker, arg}
      {Finch, name: RitoPlsFinch},
      {Registry, name: RitoPls.WatchRegistry, keys: :unique}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: RitoPls.Supervisor]
    Supervisor.start_link(children, opts)
  end
end

defmodule RitoPls.Runtime.WatchProcess do
  use GenServer, restart: :transient

  alias RitoPls.Runtime.GamesSupervisor

  def game(summoner_name) when is_binary(summoner_name) do
    {:via, Registry, {RitoPls.WatchRegistry, {__MODULE__, summoner_name}}}
  end
end

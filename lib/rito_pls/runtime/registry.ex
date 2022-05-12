defmodule RitoPls.Registry do
  @moduledoc """
  Used to key-value store GenServers.

  In the scope of this app, the keys are summoner names and the value are GenServer pids.
  """
  use GenServer

  def start_link(opts) do
    GenServer.start_link(__MODULE__, :ok, opts)
  end

  def lookup(server, name) do
    GenServer.call(server, {:lookup, name})
  end

  def read_all(server) do
    GenServer.call(server, {:read_all})
  end

  def create(server, name) do
    GenServer.cast(server, {:create, name})
  end

  @impl true
  def init(:ok) do
    names = %{}
    refs = %{}
    {:ok, {names, refs}}
  end

  @impl true
  def handle_call({:lookup, name}, _from, state) do
    {names, _} = state
    {:reply, Map.fetch(names, name), state}
  end

  def handle_call({:read_all}, _from, state) do
    {names, _} = state
    {:reply, names, state}
  end

  @impl true
  def handle_cast({:create, name}, {names, refs}) do
    if Map.has_key?(names, name) do
      {:noreply, {names, refs}}
    else
      {:ok, pid} =
        DynamicSupervisor.start_child(
          RitoPls.SummonerMatchMonitorSupervisor,
          {RitoPls.SummonerMatchMonitor,
           %{"summoner_name" => name, "started" => DateTime.now!("Etc/UTC"), "matches" => []}}
        )

      ref = Process.monitor(pid)
      refs = Map.put(refs, ref, name)
      names = Map.put(names, name, pid)
      {:noreply, {names, refs}}
    end
  end

  @impl true
  def handle_info(msg, state) do
    require Logger
    Logger.debug("Unexpected message in RitoPls.Registry: #{inspect(msg)}")
    {:noreply, state}
  end
end

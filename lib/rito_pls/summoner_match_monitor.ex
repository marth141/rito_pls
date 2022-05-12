defmodule RitoPls.SummonerMatchMonitor do
  use GenServer

  def read(server) do
    GenServer.call(server, :read)
  end

  # Callbacks
  def start_link(opts) do
    GenServer.start_link(__MODULE__, opts)
  end

  def push(pid, element) do
    GenServer.cast(pid, {:push, element})
  end

  def pop(pid) do
    GenServer.call(pid, :pop)
  end

  @impl true
  def init(stack) do
    {:ok, stack, {:continue, :init}}
  end

  @impl true
  def handle_continue(:init, state) do
    with {:ok, new_matches} <- force_get_matches(state) do
      state =
        Map.update!(state, "matches", fn previous_matches ->
          [new_matches | previous_matches] |> List.flatten()
        end)

      schedule_poll()
      {:noreply, state}
    else
      e -> IO.inspect(e)
    end
  end

  @impl true
  def handle_info(:check_for_matches, state) do
    if(DateTime.diff(DateTime.now!("Etc/UTC"), state["started"]) >= 3600) do
      {:stop, "Lived too long", state}
    end

    summoner_name = Map.get(state, "summoner_name")
    {:ok, matches} = force_get_matches(state)

    new_matches = state["matches"] -- matches

    if new_matches != [] do
      "New matches for #{summoner_name}\n#{inspect(new_matches)}\n"
    end

    state =
      Map.update!(state, "matches", fn previous_matches when is_list(previous_matches) ->
        [new_matches | previous_matches] |> List.flatten()
      end)

    schedule_poll()
    {:noreply, state}
  end

  def handle_info(_, state) do
    {:noreply, state}
  end

  @impl true
  def handle_call(:read, _from, state) do
    {:reply, state, state}
  end

  def handle_call(:pop, _from, [head | tail]) do
    {:reply, head, tail}
  end

  def handle_call(_msg, _from, state) do
    {:reply, "I don't know that call", state}
  end

  @impl true
  def handle_cast({:push, element}, state) do
    {:noreply, [element | state]}
  end

  def handle_cast(_msg, state) do
    {:noreply, state}
  end

  defp force_get_matches(state) do
    with {:ok, %Finch.Response{status: 200, body: body}} <-
           RitoPls.MatchV5.get_matches_by_puuid(state["summoner_name"], count: 5) do
      {:ok,
       body
       |> Jason.decode!()}
    else
      {:ok, %Finch.Response{status: 429}} -> force_get_matches(state)
      {:error, %Mint.TransportError{}} -> force_get_matches(state)
    end
  end

  defp schedule_poll do
    Process.send_after(self(), :check_for_matches, :timer.minutes(1))
  end
end

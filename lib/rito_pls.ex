defmodule RitoPls do
  @moduledoc """
  Documentation for `RitoPls`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> RitoPls.hello()
      :world

  """
  def hello do
    :world
  end

  def give_it_a_whirl(summoner_name, _region) do
    summoner =
      RitoPls.SummonerV4.get_summoner_by_summoner_name!(summoner_name)
      |> extract_body()

    matches =
      RitoPls.MatchV5.get_matches_by_puuid(summoner["puuid"], count: 5)
      |> extract_body()

    players_to_monitor =
      matches
      |> Enum.map(fn match_id ->
        RitoPls.MatchV5.get_match_by_match_id(match_id) |> extract_body
      end)
      |> Enum.map(fn match -> match["metadata"]["participants"] end)
      |> List.flatten()

    players_to_monitor
    |> Enum.each(fn player_id -> RitoPls.Registry.create(RitoPls.Registry, player_id) end)
  end

  def write_to_json(json_string, file_name) when is_binary(json_string) do
    File.touch("#{file_name}.json")

    File.write("#{file_name}.json", json_string)
  end

  def write_to_json(json_string, file_name) when is_map(json_string) do
    File.touch("#{file_name}.json")

    File.write("#{file_name}.json", json_string |> Jason.encode!())
  end

  defp extract_body({:ok, %Finch.Response{} = response}) do
    response.body
    |> Jason.decode!()
  end

  defp extract_body(%Finch.Response{} = response) do
    response.body
    |> Jason.decode!()
  end
end

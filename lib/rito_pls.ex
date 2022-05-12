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

  @doc """
  Given a `summoner_name` and `region` will monitor all of the players from the
  given player's last five matches for new matches every minute for the next hour.

  ## Supported Regions

    - Americas

  """
  def give_it_a_whirl(summoner_name, region) do
    if is_nil(summoner_name) or not is_binary(summoner_name) do
      raise "No summoner name given"
    end

    if is_nil(RitoPls.RegionDictionary.get()[region]) or not is_binary(region) do
      raise "No supported region given"
    end

    region_info = RitoPls.RegionDictionary.get()[region]

    summoner =
      RitoPls.SummonerV4.get_summoner_by_summoner_name!(
        summoner_name,
        region_info["platforms"] |> List.first()
      )
      |> extract_body()

    matches =
      RitoPls.MatchV5.get_matches_by_puuid(summoner["puuid"],
        count: 5,
        region: region_info["region"]
      )
      |> extract_body()

    players_to_monitor =
      matches
      |> Enum.map(fn match_id ->
        RitoPls.MatchV5.get_match_by_match_id(match_id, region_info["region"]) |> extract_body
      end)
      |> Enum.map(fn match -> match["metadata"]["participants"] end)
      |> List.flatten()

    players_to_monitor
    |> Enum.each(fn player_id -> RitoPls.Registry.create(RitoPls.Registry, player_id) end)
  end

  @doc false
  def give_it_a_whirl(_summoner_name) do
    raise "No region given"
  end

  @doc false
  def give_it_a_whirl() do
    raise "No summoner name or region given"
  end

  def read_registry() do
    RitoPls.Registry.read_all(RitoPls.Registry)
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

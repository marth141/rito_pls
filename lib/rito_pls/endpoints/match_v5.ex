defmodule RitoPls.MatchV5 do
  alias RitoPls.Finches.{
    RegionFinch
  }

  def get_matches_by_puuid(puuid, opts \\ []) do
    region = Keyword.get(opts, :region, nil)

    query_params =
      opts
      |> Enum.filter(fn
        {:region, _region} -> false
        {_atom, value} when is_nil(value) -> false
        {_atom, _value} -> true
      end)
      |> Enum.map(fn
        {atom, value} -> "&#{to_string(atom)}=#{value}"
      end)
      |> List.to_string()

    if is_nil(region) do
      RegionFinch.get("/lol/match/v5/matches/by-puuid/#{puuid}/ids?#{query_params}")
    else
      RegionFinch.get("/lol/match/v5/matches/by-puuid/#{puuid}/ids?#{query_params}", region)
    end
  end

  def get_match_by_match_id(match_id, region) do
    RegionFinch.get("/lol/match/v5/matches/#{match_id}?", region)
  end

  def get_match_by_match_id(match_id) do
    RegionFinch.get("/lol/match/v5/matches/#{match_id}?")
  end
end

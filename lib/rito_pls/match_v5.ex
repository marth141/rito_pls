defmodule RitoPls.MatchV5 do
  alias RitoPls.Finches.{
    RegionFinch
  }

  def get_matches_by_puuid(puuid, opts \\ []) do
    query_params =
      opts
      |> Enum.filter(fn
        {_atom, string} when is_nil(string) -> false
        {_atom, _string} -> true
      end)
      |> Enum.map(fn
        {atom, value} -> "&#{to_string(atom)}=#{value}"
      end)
      |> List.to_string()

    RegionFinch.get("/lol/match/v5/matches/by-puuid/#{puuid}/ids?#{query_params}")
  end

  def get_match_by_match_id(match_id) do
    RegionFinch.get("/lol/match/v5/matches/#{match_id}?")
  end
end

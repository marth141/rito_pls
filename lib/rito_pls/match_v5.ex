defmodule RitoPls.MatchV5 do
  alias RitoPls.Finches.{
    RegionFinch
  }

  def get_matches_by_puuid(
        puuid \\ "5hqMoTw8THByjN-xLfJ2DKjqYlCXrPzdLA49KpiFbYU7fFBGzs6bhuDaoubEXh1xaS1gN42FbH0PKw"
      ) do
    {:ok, _finch_response} =
      response = RegionFinch.get("/lol/match/v5/matches/by-puuid/#{puuid}/ids")

    response
  end

  def get_match_by_match_id(match_id) do
    RegionFinch.get("/lol/match/v5/matches/#{match_id}")
  end

  def test_matches() do
    [
      "NA1_4183446774",
      "NA1_4183409240",
      "NA1_4183371412",
      "NA1_4183359688",
      "NA1_4183226671",
      "NA1_4183212491",
      "NA1_4182577294",
      "NA1_4182512867",
      "NA1_4117419867",
      "NA1_4113922052",
      "NA1_3997656785",
      "NA1_3996048940",
      "NA1_3996032729",
      "NA1_3996026301",
      "NA1_3995941044",
      "NA1_3995935605",
      "NA1_3995929183",
      "NA1_3916396733",
      "NA1_3909476346"
    ]
    |> Task.async_stream(fn match_id ->
      {:ok, %{body: body}} = get_match_by_match_id(match_id)
      body |> Jason.decode!()
    end)
    |> Stream.map(fn {:ok, thing} -> thing end)
    |> Enum.to_list()
    |> Enum.map(fn match ->
      match["info"]["participants"]
    end)

    # With our list of participants, query them for matches every minute for 1 hour
  end
end

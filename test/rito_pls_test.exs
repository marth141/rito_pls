defmodule RitoPlsTest do
  use ExUnit.Case
  doctest RitoPls

  test "greets the world" do
    assert RitoPls.hello() == :world
  end

  test "testing genservery things" do
    RitoPls.SummonerV4.get_summoner_by_summoner_name!("kerothedark")
    |> IO.inspect()
  end

  test "testing genservery things" do
    RitoPls.AccountV1.get_account_by_riot_id!("kerothedark", "na1")
    |> IO.inspect()
  end
end

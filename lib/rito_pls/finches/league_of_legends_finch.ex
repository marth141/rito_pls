defmodule RitoPls.Finches.LeagueOfLegendsFinch do
  @base_url "https://na1.api.riotgames.com"
  @api_key Application.get_env(:rito_pls, :api_key)
  def get(uri) do
    Finch.build(:get, "#{@base_url}#{uri}?api_key=#{@api_key}")
    |> Finch.request(RitoPlsFinch)
  end
end

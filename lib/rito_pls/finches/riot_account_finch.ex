defmodule RitoPls.Finches.RiotAccountFinch do
  @base_url "https://americas.api.riotgames.com"
  @api_key Application.get_env(:rito_pls, :api_key)
  def get(uri) do
    Finch.build(:get, "#{@base_url}#{uri}?api_key=#{@api_key}")
    |> Finch.request(RitoPlsFinch)
  end
end

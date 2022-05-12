defmodule RitoPls.Finches.RegionFinch do
  @base_url "api.riotgames.com"
  @api_key Application.get_env(:rito_pls, :api_key)
  def get(uri, region \\ "americas") do
    Finch.build(:get, "https://#{region}.#{@base_url}#{uri}&api_key=#{@api_key}")
    |> IO.inspect()
    |> Finch.request(RitoPlsFinch)
  end
end

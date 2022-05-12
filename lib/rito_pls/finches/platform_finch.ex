defmodule RitoPls.Finches.PlatformFinch do
  @base_url "api.riotgames.com"
  @api_key Application.get_env(:rito_pls, :api_key)
  def get(uri, platform \\ "na1") do
    Finch.build(:get, "https://#{platform}.#{@base_url}#{uri}&api_key=#{@api_key}")
    |> Finch.request(RitoPlsFinch)
  end
end

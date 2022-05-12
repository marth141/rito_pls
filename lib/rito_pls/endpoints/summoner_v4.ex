defmodule RitoPls.SummonerV4 do
  alias RitoPls.Finches.{
    PlatformFinch
  }

  @doc """
  Gets a league of legends summoner by `:summoner_name`

  ## Parameters

    - summoner_name: A league of legends summoner name

  ## Examples

      iex> RitoPls.SummonerV4.get_summoner_by_summoner_name(summoner_name: "kerothedark")
      {:ok, %Finch.Response{}}

  """

  def get_summoner_by_summoner_name(summoner_name, region) do
    with {:ok, _finch_response} = response <-
           PlatformFinch.get("/lol/summoner/v4/summoners/by-name/#{summoner_name}", region) do
      response
    else
      e -> {:error, e}
    end
  end

  def get_summoner_by_summoner_name(summoner_name) do
    with {:ok, _finch_response} = response <-
           PlatformFinch.get("/lol/summoner/v4/summoners/by-name/#{summoner_name}") do
      response
    else
      e -> {:error, e}
    end
  end

  @doc false
  def get_summoner_by_summoner_name() do
    {:error, nil}
  end

  @doc """
  Gets a league of legends summoner by `:summoner_name`

  ## Parameters

    - summoner_name: A league of legends summoner name

  ## Examples

      iex> RitoPls.SummonerV4.get_summoner_by_summoner_name!(summoner_name: "kerothedark")
      %Finch.Response{}

  """
  def get_summoner_by_summoner_name!(summoner_name, region) do
    with {:ok, finch_response} = _response <-
           PlatformFinch.get("/lol/summoner/v4/summoners/by-name/#{summoner_name}?", region) do
      finch_response
    else
      e -> {:error, e}
    end
  end

  def get_summoner_by_summoner_name!(summoner_name) do
    with {:ok, finch_response} = _response <-
           PlatformFinch.get("/lol/summoner/v4/summoners/by-name/#{summoner_name}?") do
      finch_response
    else
      e -> {:error, e}
    end
  end

  @doc false
  def get_summoner_by_summoner_name!() do
    raise(ArgumentError, """
    No parameters given

    ## Parameters

      - summoner_name: A league of legends summoner name
    """)
  end
end

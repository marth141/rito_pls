defmodule RitoPls.AccountV1 do
  alias RitoPls.Finches.{
    RegionFinch
  }

  @doc """
  Gets a riot account by `:game_name` and `:tag_line`

  ## Parameters

    - game_name: A player's name
    - tag_line: A player's #tag

  ## Examples

      iex> RitoPls.AccountV1.get_account_by_riot_id(game_name: "kerothedark", tag_line: "na1")
      {:ok, %Finch.Response{}}

  """
  def get_account_by_riot_id(game_name, tag_line) do
    with {:ok, _finch_response} = response <-
           RegionFinch.get("/riot/account/v1/accounts/by-riot-id/#{game_name}/#{tag_line}?") do
      response
    else
      e -> {:error, e}
    end
  end

  @doc false
  def get_account_by_riot_id() do
    {:error, nil}
  end

  @doc """
  Gets a riot account by `:game_name` and `:tag_line`

  ## Parameters

    - game_name: A player's name
    - tag_line: A player's #tag

  ## Examples

      iex> RitoPls.AccountV1.get_account_by_riot_id!(game_name: "kerothedark", tag_line: "na1")
      %Finch.Response{}

  """
  def get_account_by_riot_id!(game_name, tag_line) do
    with {:ok, finch_response} = _response <-
           RegionFinch.get("/riot/account/v1/accounts/by-riot-id/#{game_name}/#{tag_line}?") do
      finch_response
    else
      e -> {:error, e}
    end
  end

  @doc false
  def get_account_by_riot_id!() do
    raise(ArgumentError, """
    No parameters given

    ## Parameters

      - game_name: A player name
      - tag_line: A player #tag
    """)
  end
end

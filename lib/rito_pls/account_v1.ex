defmodule RitoPls.AccountV1 do
  alias RitoPls.Changesets.{
    GetAccountByRiotIdRequest
  }

  alias RitoPls.Finches.{
    RiotAccountFinch
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
  def get_account_by_riot_id([game_name: game_name, tag_line: tag_line] = opts) do
    with %Ecto.Changeset{valid?: true} <-
           GetAccountByRiotIdRequest.changeset(
             %GetAccountByRiotIdRequest{},
             Map.new(opts)
           ),
         {:ok, _finch_response} = response <-
           RiotAccountFinch.get("/riot/account/v1/accounts/by-riot-id/#{game_name}/#{tag_line}") do
      response
    else
      %Ecto.Changeset{valid?: false, errors: errors} ->
        {:error, Kernel.inspect(errors)}
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
  def get_account_by_riot_id!([game_name: game_name, tag_line: tag_line] = opts) do
    with %Ecto.Changeset{valid?: true} <-
           GetAccountByRiotIdRequest.changeset(
             %GetAccountByRiotIdRequest{},
             Map.new(opts)
           ),
         {:ok, finch_response} = _response <-
           RiotAccountFinch.get("/riot/account/v1/accounts/by-riot-id/#{game_name}/#{tag_line}") do
      finch_response
    else
      %Ecto.Changeset{valid?: false, errors: errors} ->
        raise(ArgumentError, Kernel.inspect(errors))
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

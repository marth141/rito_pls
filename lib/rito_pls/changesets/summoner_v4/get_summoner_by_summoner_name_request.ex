defmodule RitoPls.Changesets.GetSummonerBySummonerNameRequest do
  use Ecto.Schema
  import Ecto.Changeset

  embedded_schema do
    field(:summoner_name, :string)
  end

  def changeset(request, attrs) do
    request
    |> cast(attrs, [:summoner_name])
    |> validate_required([:summoner_name])
  end
end

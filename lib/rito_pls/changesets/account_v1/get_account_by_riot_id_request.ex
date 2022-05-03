defmodule RitoPls.Changesets.GetAccountByRiotIdRequest do
  use Ecto.Schema
  import Ecto.Changeset

  embedded_schema do
    field(:game_name, :string)
    field(:tag_line, :string)
  end

  def changeset(request, attrs) do
    request
    |> cast(attrs, [:game_name, :tag_line])
    |> validate_required([:game_name, :tag_line])
  end
end

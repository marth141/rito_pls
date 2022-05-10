defmodule RitoPls do
  @moduledoc """
  Documentation for `RitoPls`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> RitoPls.hello()
      :world

  """
  def hello do
    :world
  end

  def write_to_json(json_string, file_name) do
    File.touch("#{file_name}.json")

    File.write("#{file_name}.json", json_string)
  end
end

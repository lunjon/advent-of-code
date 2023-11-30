defmodule Advent.Util.Input do
  @doc """
  Read lines from file and return as is.
  """
  def lines(filepath) do
    read_lines(filepath, &(&1))
  end

  def lines(filepath, mapfunc) do
    read_lines(filepath, mapfunc)
  end

  defp read_lines(filepath, mapfunc) do
    File.read!(filepath)
    |> String.split("\n")
    |> Enum.map(&String.trim/1)
    |> Enum.map(mapfunc)
  end
end

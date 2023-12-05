defmodule Advent.Util.Input do
  @doc """
  Just read filepath and return as string.
  """
  def string(filepath), do: File.read!(filepath)

  @doc """
  Read lines from file and return as is.
  """
  def lines(filepath, trim \\ true) do
    read_lines(filepath, & &1, trim)
  end

  @doc """
  Read lines from file and run each line through `mapfunc`.
  """
  def lines(filepath, mapfunc, trim) do
    read_lines(filepath, mapfunc, trim)
  end

  defp read_lines(filepath, mapfunc, trim) do
    File.read!(filepath)
    |> String.split("\n", trim: trim)
    |> Enum.map(mapfunc)
  end
end

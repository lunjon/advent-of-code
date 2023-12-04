defmodule Advent.Util.Iter do
  @spec to_integers([String.t()]) :: [integer()]
  def to_integers(numbers) do
    numbers
    |> Enum.map(fn num ->
      Integer.parse(num) |> elem(0)
    end)
  end
end

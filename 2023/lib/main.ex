defmodule Advent.Main do
  alias Advent.Util.Input

  def main(_args) do
    days()
    |> Enum.map(&get_input/1)
    |> Enum.map(fn {input, mod} ->
      Task.async(mod, :run, [input])
    end)
    |> Task.await_many(10_000)
    |> Enum.each(fn result ->
      IO.puts(result)
    end)
  end

  defp get_input({day, mod, :lines}) do
    lines = Input.lines("inputs/day#{day}.txt")
    {lines, mod}
  end

  defp get_input({day, mod, :string}) do
    input = Input.string("inputs/day#{day}.txt")
    {input, mod}
  end

  defp days() do
    [
      {1, Advent.Day1, :lines},
      {2, Advent.Day2, :lines}
    ]
  end
end

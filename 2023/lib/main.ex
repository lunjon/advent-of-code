defmodule Advent.Main do
  alias Advent.Util.Input

  def main(_args) do
    days()
    |> Enum.with_index(&get_input/2)
    |> Enum.map(fn {input, mod} ->
      Task.async(mod, :run, [input])
    end)
    |> Task.await_many(10_000)
    |> Enum.each(fn result ->
      IO.puts(result)
    end)
  end

  defp get_input({mod, :lines}, index) do
    lines = Input.lines("inputs/day#{index + 1}.txt")
    {lines, mod}
  end

  defp get_input({mod, :string}, index) do
    input = Input.string("inputs/day#{index + 1}.txt")
    {input, mod}
  end

  defp days() do
    [
      {Advent.Day1, :lines}
    ]
  end
end

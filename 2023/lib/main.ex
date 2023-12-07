defmodule Advent.Main do
  alias Advent.Util.Input

  def main(_args) do
    days()
    |> Enum.map(&get_input/1)
    |> Enum.map(fn {input, mod} ->
      Task.async(mod, :run, [input])
    end)
    |> Task.await_many(30_000)
    |> Enum.each(&IO.puts/1)
  end

  defp get_input({day, mod, :lines}) do
    lines = Input.lines(input_file(day))
    {lines, mod}
  end

  defp get_input({day, mod, :lines_no_trim}) do
    lines = Input.lines(input_file(day), false)
    {lines, mod}
  end

  defp get_input({day, mod, :string}) do
    input = Input.string(input_file(day))
    {input, mod}
  end

  defp days() do
    [
      {1, Advent.Day1, :lines},
      {2, Advent.Day2, :lines},
      {3, Advent.Day3, :lines},
      {4, Advent.Day4, :lines},
      {5, Advent.Day5, :lines_no_trim},
      {6, Advent.Day6, :lines}

    ]
  end

  defp input_file(day), do: "inputs/day#{day}.txt" 
end

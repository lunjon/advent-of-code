defmodule Advent.Main do
  def main(_args) do
    days = [
      Advent.Day1,
    ]

    days
    |> Enum.with_index(fn(mod, index) ->
      {input_file(index+1), mod}
    end)
    |> Enum.map(fn {filepath, mod} ->
      Task.async(mod, :run, [filepath])
    end)
    |> Task.await_many(10_000)
    |> Enum.each(fn result ->
      IO.puts(result)
    end)
  end

  defp input_file(day) do
    "inputs/day#{day}.txt"
  end
end

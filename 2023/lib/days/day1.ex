defmodule Advent.Day1 do
  def run(filepath) do
    Advent.Util.Input.lines(filepath)
    |> Enum.join(", ")
  end
end

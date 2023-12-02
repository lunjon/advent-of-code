defmodule AdventTest do
  use ExUnit.Case
  alias Advent.Util.Input

  doctest Advent.Day2

  @day 1

  test("solution for day #{@day}", %{lines: lines}) do
    result = Advent.Day2.part1(lines)
    assert result == 8
  end

  setup(_) do
    filename = "day#{@day}.txt"
    lines = Input.lines("inputs/#{filename}")
    string = Input.string("inputs/#{filename}")
    {:ok, lines: lines, string: string}
  end
end

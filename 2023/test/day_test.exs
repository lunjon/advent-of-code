defmodule Test.Day do
  use ExUnit.Case  
  alias Advent.Util.Input

  # I use this for faster iteration where I can
  # test a particular solution.

  @day 1

  test("solution for day #{@day}", %{lines: lines}) do
    result = Advent.Day1.part2(lines)
    assert result == 281
  end

  setup(_) do
    filename = "day#{@day}.sample.txt"
    lines = Input.lines("inputs/#{filename}")
    string = Input.string("inputs/#{filename}")
    {:ok, lines: lines, string: string}
  end
end


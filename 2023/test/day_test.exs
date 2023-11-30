defmodule Test.Day do
  use ExUnit.Case  
  alias Advent.Util.Input

  # I use this for faster iteration where I can
  # test a particular solution.

  @day 1

  test("solution for day #{@day}", %{lines: lines}) do
    result = Advent.Day1.run(lines)
    assert result =~ ~r/one, two/
  end

  setup(_) do
    lines = Input.lines("inputs/day#{@day}.txt")
    string = Input.string("inputs/day#{@day}.txt")
    {:ok, lines: lines, string: string}
  end
end


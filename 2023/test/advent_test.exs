defmodule AdventTest do
  use ExUnit.Case
  alias Advent.Util.Input

  # doctest Advent.Day4

  test("solution for advent") do
    lines = Input.lines("inputs/day6.sample.txt")
    res = Advent.Day6.run(lines)
    assert res == 288

    # res = Advent.Day6.solve(30,200)
    # assert res === 9
  end
end

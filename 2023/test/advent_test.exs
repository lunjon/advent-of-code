defmodule AdventTest do
  use ExUnit.Case
  alias Advent.Util.Input

  # doctest Advent.Day4

  test("solution for advent") do
    lines = Input.lines("inputs/day5.sample.txt", false)
    _ = Advent.Day5.run(lines)
  end
end

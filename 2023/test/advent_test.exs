defmodule AdventTest do
  use ExUnit.Case
  alias Advent.Util.Input

  doctest Advent.Day4

  test("solution for advent") do
    lines = Input.lines("inputs/day4.sample.txt")
    _ = Advent.Day4.run(lines)
  end
end

defmodule AdventTest do
  use ExUnit.Case
  alias Advent.Util.Input

  doctest Advent.Day2
  doctest Advent.Day3

  test("solution for advent") do
    lines = Input.lines("inputs/day3.sample.txt")
    assert Advent.Day3.part1(lines) == 4361
    assert Advent.Day3.part2(lines) == 467_835
  end
end

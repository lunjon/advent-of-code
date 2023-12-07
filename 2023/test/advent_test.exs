defmodule AdventTest do
  use ExUnit.Case
  alias Advent.Util.Input

  test("solution for advent") do
    lines = Input.lines("inputs/day7.sample.txt")
    _ = Advent.Day7.run(lines)
  end
end

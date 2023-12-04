defmodule Test.Util.Iter do
  use ExUnit.Case
  alias Advent.Util.Iter

  describe("Iter.to_integers/1 should") do
    test("return numbers as integers") do
      numbers = Iter.to_integers(["1", "9", "20", "32"])
      assert length(numbers) == 4

      for n <- numbers do
        assert is_number(n)
      end
    end
  end
end

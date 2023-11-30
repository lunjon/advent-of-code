defmodule Test.Util.Input do
  use ExUnit.Case
  alias Advent.Util.Input

  describe("Input.lines/1 should") do
    test("return lines given file") do
      lines = Input.lines("README.md")
      assert length(lines) > 0
    end

    test("raise error given unknown file") do
      assert_raise(File.Error, fn -> Input.lines("unknown-file.txt") end)
    end
  end

  describe("Input.lines/2 should") do
    test("transform lines given mapping function") do
      lines =
        Input.lines("README.md", fn line ->
          "#{line}-ok"
        end)

      assert length(lines) > 0

      assert Enum.each(lines, fn s ->
               String.ends_with?(s, "-ok")
             end)
    end
  end
end

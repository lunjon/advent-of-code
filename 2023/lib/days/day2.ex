defmodule Advent.Day2 do
  def run(lines) do
    games = Enum.map(lines, &parse/1)
    "Day 2: #{part1(games)}, #{part2(games)}"
  end

  def part1(games) do
    games
    |> Enum.map(fn {id, {r, g, b}} ->
      case r <= 12 and g <= 13 and b <= 14 do
        true -> id
        false -> 0
      end
    end)
    |> Enum.sum()
  end

  def part2(games) do
    Enum.reduce(games, 0, fn {_, {r, g, b}}, sum ->
      r * g * b + sum
    end)
  end

  @doc """
  ## Examples
      iex> Advent.Day2.parse("Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green")
      {1, {4, 6, 2}}
  """
  def parse(line) do
    [game, sets] = String.split(line, ": ")
    [_, id] = String.split(game, " ")
    {id, ""} = Integer.parse(id)

    counts =
      String.split(sets, "; ")
      |> Enum.reduce(%{}, fn set, acc ->
        reduce_set(acc, set)
      end)

    {id, {counts["red"], counts["green"], counts["blue"]}}
  end

  defp reduce_set(game, set) do
    String.split(set, ", ")
    |> Enum.reduce(game, fn count, acc ->
      [n, color] = String.split(count, " ")
      {n, ""} = Integer.parse(n)

      Map.update(acc, color, n, fn curr ->
        if n > curr do
          n
        else
          curr
        end
      end)
    end)
  end
end

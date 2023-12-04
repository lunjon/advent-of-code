defmodule Advent.Day4 do
  alias Advent.Util.Iter

  def run(lines) do
    cards = Enum.map(lines, &parse_line/1)
    "Day 4: #{part1(cards)}, #{part2(cards)}"
  end

  defp part1(cards) do
    cards
    |> Enum.map(&get_winning_numbers/1)
    |> Enum.map(&get_score/1)
    |> Enum.sum()
  end

  defp part2(cards) do
    cache =
      Enum.map(cards, fn card -> {card.id, 1} end)
      |> Map.new()

    map =
      Enum.map(cards, fn card -> {card.id, card} end)
      |> Map.new()

    Enum.reduce(cards, cache, fn card, cache ->
      curr = Map.get(cache, card.id, 0)
      count = get_winning_numbers(card) |> Enum.count()

      collect_cards(map, card.id, count)
      |> Enum.reduce(cache, fn card, cache ->
        Map.update(cache, card.id, 1, fn val -> val + curr end)
      end)
    end)
    |> Enum.map(fn {_, v} -> v end)
    |> Enum.sum()
  end

  defp get_winning_numbers(%{winning: wins, numbers: nums}) do
    for n <- nums, n in wins, do: n
  end

  defp get_score([]), do: 0

  defp get_score(numbers), do: get_score(numbers, 1)

  defp get_score([], n), do: div(n, 2)

  defp get_score([_ | rest], n) do
    get_score(rest, n * 2)
  end

  defp collect_cards(_map, _id, 0), do: []

  defp collect_cards(map, id, count) do
    for n <- 1..count, Map.has_key?(map, id + n) do
      Map.get(map, id+n)
    end
  end

  # Parsing
  # =======

  @spec parse_line(String.t()) :: map()
  defp parse_line(line) do
    [id, list] = String.split(line, ": ")
    [_, id] = String.split(id)
    [winning, numbers] = String.split(list, " | ")
    winning = String.split(winning) |> Iter.to_integers()
    numbers = String.split(numbers) |> Iter.to_integers()

    {id, ""} = Integer.parse(id)
    %{id: id, winning: winning, numbers: numbers}
  end
end

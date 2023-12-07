defmodule Advent.Day7 do
  @labels %{
    "A" => "m",
    "K" => "l",
    "Q" => "k",
    "J" => "j",
    "T" => "i",
    "9" => "h",
    "8" => "g",
    "7" => "f",
    "6" => "e",
    "5" => "d",
    "4" => "c",
    "3" => "b",
    "2" => "a"
  }
  @card_names [:high_card, :one_pair, :two_pair, :three, :full_house, :four, :five]

  def run(lines) do
    hands = Enum.map(lines, &parse_line/1)

    bids =
      hands
      |> Enum.map(fn {hand, bid, _} ->
        {hand, bid}
      end)
      |> Map.new()

    map =
      hands
      |> Enum.map(fn {hand, _, _} ->
        label =
          String.codepoints(hand)
          |> Enum.map(&@labels[&1])
          |> Enum.join()

        {hand, label}
      end)
      |> Map.new()

    vmap = Enum.map(map, fn {k, v} -> {v, k} end) |> Map.new()

    "Day7: #{part1(hands, bids, map, vmap)}"
  end

  def part1(hands, bids, map, vmap) do
    sorted =
      Enum.group_by(hands, &elem(&1, 2))
      |> Enum.map(fn {type, hands} ->
        sorted =
          Enum.map(hands, &elem(&1, 0))
          |> sort_hands(map, vmap)

        {type, sorted}
      end)
      |> Map.new()

    {_, mapped} =
      Enum.reduce(@card_names, {1, []}, fn type, {acc, ls} ->
        case sorted[type] do
          nil ->
            {acc, ls}

          list ->
            count = length(list)
            range = acc..(acc + count)
            newls = Enum.zip(Range.to_list(range), list)
            {acc + count, ls ++ newls}
        end
      end)

    
    Enum.map(mapped, fn {rank, hand} ->
      rank * bids[hand]
    end)
    |> Enum.sum()
  end

  defp parse_line(line) do
    [hand, bid] = String.split(line)

    type =
      String.codepoints(hand)
      |> Enum.frequencies()
      |> Map.new()
      |> get_type()

    {bid, ""} = Integer.parse(bid)
    {hand, bid, type}
  end

  def get_type(map) when map_size(map) == 5, do: :high_card
  def get_type(map) when map_size(map) == 4, do: :one_pair
  def get_type(map) when map_size(map) == 1, do: :five

  def get_type(map) when map_size(map) == 2 do
    case Map.to_list(map) do
      [{_, 4}, {_, 1}] -> :four
      [{_, 1}, {_, 4}] -> :four
      [{_, 3}, {_, 2}] -> :full_house
      [{_, 2}, {_, 3}] -> :full_house
    end
  end

  def get_type(map) when map_size(map) == 3 do
    items =
      Map.to_list(map)
      |> Enum.sort_by(&elem(&1, 1))
      |> Enum.reverse()

    case items do
      [{_, 3}, {_, 1}, {_, 1}] -> :three
      [{_, 2}, {_, 2}, {_, 1}] -> :two_pair
    end
  end

  def sort_hands(hands, map, vmap) do
    Enum.map(hands, fn hand -> map[hand] end)
    |> Enum.sort()
    |> Enum.map(fn hand -> vmap[hand] end)
  end
end

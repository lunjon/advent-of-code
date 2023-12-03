defmodule Advent.Day3 do
  def run(lines) do
    map = to_map(lines)

    parts =
      get_symbol_coords(map)
      |> Enum.map(fn coord ->
        {map[coord], get_adjacent_numbers(coord, map)}
      end)

    "Day 3: #{part1(parts)}, #{part2(parts)}"
  end

  def part1(parts) do
    Enum.map(parts, fn {_, nums} ->
      Enum.sum(nums)
    end)
    |> Enum.sum()
  end

  def part2(parts) do
    parts
    |> Enum.filter(fn {symbol, nums} ->
      symbol == "*" and Enum.count(nums) == 2
    end)
    |> Enum.map(fn {_, nums} ->
      Enum.reduce(nums, 1, &*/2)
    end)
    |> Enum.sum()
  end

  @type point :: {integer(), integer()}

  defp to_map(lines) do
    lines
    |> Enum.map(&String.codepoints/1)
    |> Enum.with_index()
    |> Enum.reduce(%{}, fn {row, index}, acc ->
      reduce(index, row, acc)
    end)
  end

  @spec reduce(integer(), [String.t()], map()) :: map
  defp reduce(y, row, schematic) do
    row
    |> Enum.with_index()
    |> Enum.reduce(schematic, fn {char, x}, sch ->
      Map.put(sch, {x, y}, char)
    end)
  end

  @spec get_adjacent_coords(map(), point()) :: [point()]
  def get_adjacent_coords(map, {x, y}) do
    [
      {x - 1, y - 1},
      {x - 1, y},
      {x - 1, y + 1},
      {x, y + 1},
      {x + 1, y + 1},
      {x + 1, y},
      {x + 1, y - 1},
      {x, y - 1}
    ]
    |> Enum.filter(fn coord -> Map.has_key?(map, coord) end)
  end

  def is_sym(char), do: char =~ ~r/[^\.0-9]/
  def is_num(nil), do: false
  def is_num(char), do: char =~ ~r/[0-9]/

  def get_symbol_coords(map) do
    Enum.filter(map, fn {_, value} ->
      is_sym(value)
    end)
    |> Enum.map(fn {coord, _} -> coord end)
  end

  def get_adjacent_numbers(coord, map) do
    get_adjacent_coords(map, coord)
    |> get_adjacent_numbers(map, [])
  end

  defp get_adjacent_numbers([], _map, acc) do
    acc
    |> Enum.map(fn num -> Integer.parse(num) |> elem(0) end)
  end

  defp get_adjacent_numbers([next | rest], map, acc) do
    value = map[next]

    if is_num(value) do
      number = get_number_coords(map, next)
      rest = Enum.filter(rest, &(&1 not in number))
      num = join(map, number)
      get_adjacent_numbers(rest, map, acc ++ [num])
    else
      get_adjacent_numbers(rest, map, acc)
    end
  end

  def get_number_coords(map, {x, y} = coord) do
    left = take_left(map, {x - 1, y})
    right = take_right(map, {x + 1, y})
    left ++ [coord] ++ right
  end

  defp take_left(map, {x, y} = c) do
    n = map[c]

    if is_num(n) do
      take_left(map, {x - 1, y}) ++ [{x, y}]
    else
      []
    end
  end

  defp take_right(map, {x, y} = c) do
    n = map[c]

    if is_num(n) do
      [{x, y}] ++ take_right(map, {x + 1, y})
    else
      []
    end
  end

  defp join(map, coords) do
    Enum.reduce(coords, "", fn c, acc ->
      acc <> map[c]
    end)
  end
end

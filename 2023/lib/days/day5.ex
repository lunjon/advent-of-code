defmodule Advent.Day5 do
  alias Advent.Util.Iter

  @pipeline [
    "seed-to-soil",
    "soil-to-fertilizer",
    "fertilizer-to-water",
    "water-to-light",
    "light-to-temperature",
    "temperature-to-humidity",
    "humidity-to-location"
  ]

  def run(lines) do
    [seeds, _ | maps] = lines

    seeds = get_seeds(seeds)
    registry = parse_maps(maps)

    "Day 5: #{part1(seeds, registry)}, #{part2(seeds, registry)}"
  end

  def part1(seeds, registry) do
    seeds
    |> Enum.map(&get_seed_location(registry, &1))
    |> Enum.min()
  end

  def part2(seeds, registry) do
    seeds
    |> Stream.chunk_every(2)
    |> Stream.map(fn [a, b] ->
      Range.to_list(a..(a+b-1))
      |> Enum.map(fn seed ->
        get_seed_location(registry, seed)
      end)
      |> Enum.min()
    end)
    |> Enum.min()
  end

  def get_seed_location(registry, seed) do
    @pipeline
    |> Enum.reduce(seed, fn name, curr ->
      ranges = registry[name]
      get_mapped(curr, ranges)
    end)
  end

  def get_mapped(number, []), do: number

  def get_mapped(number, [range | rest]) do
    case within_range(number, range) do
      {true, n} -> n
      _ -> get_mapped(number, rest)
    end
  end

  defp get_seeds(line) do
    String.trim_leading(line, "seeds: ")
    |> String.split()
    |> Iter.to_integers()
  end

  defp parse_maps(lines) do
    Enum.reduce(lines, {%{}, nil}, &reduce_line/2)
    |> elem(0)
    |> Enum.map(fn {name, ranges} ->
      {name, create_map(ranges)}
    end)
    |> Map.new()
  end

  defp reduce_line("", {reg, nil}), do: {reg, nil}

  defp reduce_line("", {reg, {name, lines}}) do
    reg = Map.put(reg, name, lines)
    {reg, nil}
  end

  defp reduce_line(line, {reg, curr}) do
    if String.contains?(line, " map:") do
      [map_name, _] = String.split(line)
      {reg, {map_name, []}}
    else
      {name, lines} = curr
      line = String.split(line) |> Iter.to_integers()
      {reg, {name, lines ++ [line]}}
    end
  end

  def create_map(ranges) do
    ranges
    |> Enum.map(fn [dst, src, step] ->
      %{
        src: src,
        src_end: src + step - 1,
        dst: dst
      }
    end)
  end

  def within_range(num, %{src: a, src_end: b} = range)
      when a <= num and num <= b do
    {true, range.dst + (num - a)}
  end

  def within_range(num, _), do: {false, num}
end

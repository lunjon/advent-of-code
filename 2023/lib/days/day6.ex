defmodule Advent.Day6 do
  alias Advent.Util.Iter

  def run([times, distances]) do
    times = String.trim_leading(times, "Time:")  |> get_nums()
    distances = String.trim_leading(distances, "Distance:") |> get_nums()

    "Day 6: #{part1(times, distances)}, #{part2(times, distances)}"
  end

  def part1(times, distances) do
    Enum.zip(times, distances)
    |> Enum.map(fn {time, dist} ->
      solve(time, dist)
    end)
    |> Enum.product()
  end

  def part2(times, distances) do
    {time, ""} = Integer.parse(Enum.join(times))
    {dist, ""} = Integer.parse(Enum.join(distances))
    solve(time, dist)
  end

  def solve(time, dist) do
    # h = hold time, t = total time, d = distance
    # Formula: h^2 - h*t + d = 0
    th = time / 2.0
    s = :math.sqrt(th ** 2 - dist)

    a = th+s
    b = th-s

    if a == :math.floor(a) do
      trunc(a - b) - 1
    else
      trunc(:math.ceil(th+s) - :math.ceil(th-s))
    end
  end

  defp get_nums(s), do: String.split(s) |> Iter.to_integers()
end

defmodule Advent.Day1 do
  def run(lines) do
    "Day 1: #{part1(lines)}, #{part2(lines)}"
  end

  def part1(lines) do
    lines
    |> Enum.map(&get_num/1)
    |> Enum.sum()
  end

  def part2(lines) do
    lines
    |> Enum.map(&get_nums/1)
    |> Enum.sum()
  end

  def get_nums(line), do: get_nums(line, [])

  def get_nums("", acc) do
    Enum.reverse(acc)
    |> Enum.map(fn num ->
      case num do
        "one" -> "1"
        "two" -> "2"
        "three" -> "3"
        "four" -> "4"
        "five" -> "5"
        "six" -> "6"
        "seven" -> "7"
        "eight" -> "8"
        "nine" -> "9"
        n -> n
      end
    end)
    |> convert()
  end

  @reg ~r/(one|two|three|four|five|six|seven|eight|nine|[1-9])/

  def get_nums(line, acc) do
    case Regex.run(@reg, line, capture: :all_but_first, return: :index) do
      [{a, b}] ->
        num = String.slice(line, a, b)
        get_nums(String.slice(line, a+1, String.length(line)), [num | acc])

      nil ->
        get_nums(String.slice(line, 1, String.length(line)), acc)
    end
  end

  defp get_num(line) do
    line
    |> String.codepoints()
    |> Enum.filter(&(&1 =~ ~r/[1-9]/))
    |> convert()
  end

  defp convert([num]), do: convert([num, num])
  defp convert([first | rest]) do
    Integer.parse(first <> List.last(rest))
    |> elem(0)
  end
end

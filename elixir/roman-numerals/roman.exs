defmodule Roman do
  @doc """
  Convert the number to a roman number.
  """

  @main {"M", "C", "X", "I"}
  @halves {"D", "L", "V"}

  @spec numerals(pos_integer) :: String.t
  def numerals(number) do
    number
    |> to_string
    |> String.pad_leading(4, "0")
    |> String.graphemes
    |> Enum.map(&String.to_integer/1)
    |> Enum.map_reduce(0, fn v, acc -> {convert(v, acc), acc + 1} end)
    |> elem(0)
    |> Enum.join
  end

  defp convert(4, m), do: elem(@main, m) <> elem(@halves, m - 1)
  defp convert(9, m), do: elem(@main, m) <> elem(@main, m - 1)
  defp convert(v, m) when v < 5, do: elem(@main, m) |> String.duplicate(rem v, 5)
  defp convert(v, m), do: elem(@halves, m - 1) <> (elem(@main, m) |> String.duplicate(rem v, 5))
end

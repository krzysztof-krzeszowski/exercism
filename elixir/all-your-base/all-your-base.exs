defmodule AllYourBase do
  @doc """
  Given a number in base a, represented as a sequence of digits, converts it to base b,
  or returns nil if either of the bases are less than 2
  """

  def convert([], _, _), do: :nil
  def convert([0], _, _), do: [0]
  def convert([0 | t], a, b), do: convert(t, a, b)
  def convert(a, b, c) when a < 0 or b < 2 or c < 2, do: :nil
  @spec convert(list, integer, integer) :: list
  def convert(digits, base_a, base_b) do
    if Enum.any?(digits, &(&1 < 0 || &1 >= base_a)),
      do: :nil,
      else:
        digits
        |> decode(base_a)
        |> encode(base_b)
        |> Enum.reverse
  end

  defp decode(l, b, acc \\ 0)
  defp decode([], _, acc), do: acc
  defp decode([h | t], b, acc), do: decode(t, b, b * acc + h)

  defp encode(v, b, acc \\ [])
  defp encode(0, _, acc), do: acc
  defp encode(v, b, acc), do: encode(div(v - rem(v, b), b), b, acc ++ [rem(v, b)])
end

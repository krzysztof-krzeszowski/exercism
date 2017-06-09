defmodule Binary do
  @doc """
  Convert a string containing a binary number to an integer.

  On errors returns 0.
  """
  @spec to_decimal(String.t) :: non_neg_integer
  def to_decimal(string) do
    string
    |> String.graphemes
    |> Enum.reverse
    |> conv(0, 0)
  end

  defp conv(["0" | t], b, acc), do: conv(t, b + 1, acc)
  defp conv(["1" | t], b, acc), do: conv(t, b + 1, acc + :math.pow(2, b))
  defp conv([], _, acc), do: acc
  defp conv([_ | _], _, _), do: 0
end

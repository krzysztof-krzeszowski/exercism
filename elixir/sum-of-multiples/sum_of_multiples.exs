defmodule SumOfMultiples do
  @doc """
  Adds up all numbers from 1 to a given end number that are multiples of the factors provided.
  """
  def to(limit, [h | t]) when limit < h, do: 0
  @spec to(non_neg_integer, [non_neg_integer]) :: non_neg_integer
  def to(limit, factors) do
    1..limit - 1
    |> Enum.map(&(count(&1, factors)))
    |> Enum.sum
  end

  defp count(_, []), do: 0
  defp count(l, [h | t]) do
    cond do
      rem(l, h) == 0 -> l
      true -> count(l, t)
    end
  end

end

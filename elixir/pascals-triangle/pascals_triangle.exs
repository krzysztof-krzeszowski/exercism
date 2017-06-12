defmodule PascalsTriangle do
  @doc """
  Calculates the rows of a pascal triangle
  with the given height
  """
  @spec rows(integer) :: [[integer]]
  def rows(num, i \\ 1, acc \\ [[1]])
  def rows(num, i, acc) when i == num, do: acc |> Enum.reverse
  def rows(num, i, [h | t]), do: rows(num, i + 1, [next(h) | [h | t]])

  def next(a, acc \\ [])
  def next([a], acc), do: [a | acc] ++ [1]
  def next([a | [b | t]], acc), do: next([b | t], [a + b | acc])
end

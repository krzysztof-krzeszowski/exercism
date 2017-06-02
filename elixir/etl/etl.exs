defmodule ETL do
  @doc """
  Transform an index into an inverted index.

  ## Examples

  iex> ETL.transform(%{"a" => ["ABILITY", "AARDVARK"], "b" => ["BALLAST", "BEAUTY"]})
  %{"ability" => "a", "aardvark" => "a", "ballast" => "b", "beauty" =>"b"}
  """
  @spec transform(map) :: map
  def transform(input) do
    input
    |> Map.keys
    |> get_map(input)
  end

  defp get_map(l, map, acc \\ %{})
  defp get_map([], _, acc), do: acc
  defp get_map(_, [], acc), do: acc
  defp get_map(k, [h | t], acc), do: get_map(k, t, Map.update(acc, h |> String.downcase, k, &(&1)))
  defp get_map([h | t], map, acc), do: get_map(t, map, Map.merge(acc, get_map(h, Map.get(map, h))))

end

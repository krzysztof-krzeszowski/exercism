defmodule Change do
  @doc """
    Determine the least number of coins to be given to the user such
    that the sum of the coins' value would equal the correct amount of change.
    It returns {:error, "cannot change"} if it is not possible to compute the
    right amount of coins. Otherwise returns the tuple {:ok, list_of_coins}

    ## Examples

      iex> Change.generate([5, 10, 15], 3)
      {:error, "cannot change"}

      iex> Change.generate([1, 5, 10], 18)
      {:ok, [1, 1, 1, 5, 10]}

  """

  @spec generate(list, integer) :: {:ok, list} | {:error, String.t}
  def generate(_, target) when target < 0, do: {:error, "cannot change"}
  def generate(_, 0), do: {:ok, []}
  def generate(coins, target) do
    coins
    |> Enum.reduce(
      get_map(target),
      &(check_coin(&1, target, &2))
    )
    |> result(target)
  end

  defp get_map(n) do
    1..n
    |> Enum.reduce(%{}, &(Map.put(&2, &1, %{min: n + 1, coin: -1})))
    |> Map.put(0, %{min: 0, coin: 0})
  end

  defp check_coin(coin, target, map) do
    map
    |> Map.keys
    |> Enum.sort
    |> Enum.reduce(map, fn k, m -> 
                          cond do
                            coin > k -> m
                            coin == k -> Map.put(m, k, %{min: 1, coin: coin})
                            true -> if get_from_map(m, k, :min) >= (get_from_map(m, k - coin, :min) + 1),
                                      do: m |> update_map(k, coin),
                                      else: m
                          end
                        end)
  end

  defp get_from_map(m, k, what), do: m |> Map.get(k) |> Map.get(what)
  defp update_map(m, k, coin), do: m |> Map.put(k, %{min: get_from_map(m, k - coin, :min) + 1, coin: coin})

  defp result(m, t, acc \\ [])
  defp result(_, 0, acc), do: {:ok, acc}
  defp result(m, t, acc) do
    m
    |> get_from_map(t, :coin)
    |> (&(if &1 == -1, do: {:error, "cannot change"}, else: result(m, t - &1, [&1 | acc]))).()
  end
end

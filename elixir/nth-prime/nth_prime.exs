defmodule Prime do

  @doc """
  Generates the nth prime.
  """
  def nth(count, primes \\ [2])
  def nth(count, _) when is_integer(count) == false or count < 1, do: raise(:error)
  def nth(count, primes) when length(primes) == count, do: List.last(primes)
  @spec nth(non_neg_integer) :: non_neg_integer
  def nth(count, primes) do
    nth(count, primes ++ [find_next(primes, List.last(primes))])
  end

  defp find_next(primes, p) do
    if Enum.any?(primes, &(rem p, &1) == 0) do
      find_next(primes, p + 1)
    else
      p
    end
  end

end

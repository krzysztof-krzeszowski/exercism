defmodule Hamming do
  @doc """
  Returns number of differences between two strands of DNA, known as the Hamming Distance.

  ## Examples

  iex> Hamming.hamming_distance('AAGTCATA', 'TAGCGATC')
  {:ok, 4}
  """
  def hamming_distance(a, b) when length(a) != length(b), do: {:error, "Lists must be the same length"}
  @spec hamming_distance([char], [char]) :: non_neg_integer
  def hamming_distance(strand1, strand2) do
    {:ok, Enum.zip(strand1, strand2)
    |> Enum.filter(&(elem(&1, 0) != elem(&1, 1)))
    |> length}
  end
end

defmodule StringSeries do
  @doc """
  Given a string `s` and a positive integer `size`, return all substrings
  of that size. If `size` is greater than the length of `s`, or less than 1,
  return an empty list.
  """
  @spec slices(s :: String.t(), size :: integer) :: list(String.t())
  def slices(s, size) do
    cond do
      size < 1 -> []
      size == 1 -> String.codepoints s
      size > String.length s -> []
      true -> slice s, size
    end
  end

  defp slice s, n do
    0..String.length(s) - n
    |> Enum.map(&(String.slice(s, &1, n)))
  end
end


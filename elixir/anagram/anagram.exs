defmodule Anagram do
  @doc """
  Returns all candidates that are anagrams of, but not equal to, 'base'.
  """

  @spec match(String.t, [String.t]) :: [String.t]
  def match(base, candidates) do
    for w <- candidates, check_word((base |> String.downcase), (w |> String.downcase)), do: w
  end

  def check_word(a, a), do: false
  def check_word(a, b) do
    cond do
      (a |> String.graphemes |> Enum.sort) === (b |> String.graphemes |> Enum.sort) -> true
      true -> false
    end
  end
end

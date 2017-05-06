defmodule Pangram do
  @doc """
  Determines if a word or sentence is a pangram.
  A pangram is a sentence using every letter of the alphabet at least once.

  Returns a boolean.

    ## Examples

      iex> Pangram.pangram?("the quick brown fox jumps over the lazy dog")
      true

  """

  @all "abcdefghijklmnopqrstuvwxyz"

  def pangram?(""), do: nil
  @spec pangram?(String.t) :: boolean
  def pangram?(sentence) do
    sentence = sentence
    |> String.downcase
    @all
    |> String.graphemes
    |> Enum.all?(&(String.contains?(sentence, &1)))
  end
end

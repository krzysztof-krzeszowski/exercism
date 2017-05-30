defmodule Isogram do
  @doc """
  Determines if a word or sentence is an isogram
  """
  @spec isogram?(String.t) :: boolean
  def isogram?(sentence) do
    sentence
    |> String.replace(~r/[ -]/, "")
    |> String.graphemes
    |> Enum.sort
    |> Enum.reduce_while("", &(if &1 == &2, do: {:halt, false}, else: {:cont, &1}))
  end

end

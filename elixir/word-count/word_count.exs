defmodule Words do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t) :: map
  def count(sentence) do
    sentence
    |> String.replace(~r/[!@#$%^&\*(),.\?:;]/, "")
    |> String.replace("_", " ")
    |> String.downcase
    |> String.split
    |> Enum.reduce(%{}, 
      fn(word, map) ->
        if Map.has_key?(map, word) do
          Map.put(map, word, map[word] + 1)
        else
          Map.put(map, word, 1)
        end
      end
    )
  end
end

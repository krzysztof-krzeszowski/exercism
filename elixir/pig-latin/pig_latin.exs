defmodule PigLatin do
  @doc """
  Given a `phrase`, translate it a word at a time to Pig Latin.

  Words beginning with consonants should have the consonant moved to the end of
  the word, followed by "ay".

  Words beginning with vowels (aeiou) should have "ay" added to the end of the
  word.

  Some groups of letters are treated like consonants, including "ch", "qu",
  "squ", "th", "thr", and "sch".

  Some groups are treated like vowels, including "yt" and "xr".
  """
  @spec translate(phrase :: String.t()) :: String.t()
  def translate(phrase) do
    phrase
    |> String.split(" ")
    |> Enum.map(&(translate_word &1))
    |> Enum.join(" ")
  end

  defp translate_word word do
    suffix = "ay"
    sl = String.slice word, 0..2
    cond do
      Enum.member? ["squ", "thr", "sch"], sl -> String.slice(word, 3..String.length(word)) <> sl <> suffix
      true ->
        sl = String.slice word, 0..1
        cond do
          Enum.member? ["qu", "ch", "th"], sl -> String.slice(word, 2..String.length(word)) <> sl <> suffix
          Enum.member? ["yt", "xr"], sl -> word <> suffix
          true ->
            sl = String.first word
            cond do
              Enum.member?(String.codepoints("aeiou"), sl) -> word <> suffix
              true -> String.slice(word, 1..String.length(word)) <> sl <> suffix
            end
        end
    end
  end
end


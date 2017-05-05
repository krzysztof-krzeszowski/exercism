defmodule Bob do
  def hey(input) do
    input = input
    |> String.trim
    cond do
        input === "" -> "Fine. Be that way!"
        String.ends_with? input, "?" -> "Sure."
        String.downcase(input) === input -> "Whatever."
        String.upcase(input) === input -> "Whoa, chill out!"
        true -> "Whatever."
    end
  end
end

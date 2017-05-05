defmodule RunLengthEncoder do
  @doc """
  Generates a string where consecutive elements are represented as a data value and count.
  "AABBBCCCC" => "2A3B4C"
  For this example, assume all input are strings, that are all uppercase letters.
  It should also be able to reconstruct the data into its original form.
  "2A3B4C" => "AABBBCCCC"
  """
  @spec encode(String.t) :: String.t
  def encode(string) when string == "", do: ""
  def encode(string) do
    string
    |> String.graphemes
    |> enc
  end
  defp enc(l, acc \\ "")
  defp enc([], acc), do: acc
  defp enc(l, acc) do
    [h | _] = l
    n = Enum.reduce_while(l, 0, &(if &1 == h, do: {:cont, &2 + 1}, else: {:halt, &2}))
    acc = 
      case n do
        1 -> acc <> h
        _ -> acc <> to_string(n) <> h
      end
    enc(Enum.drop(l, n), acc)
  end

  @spec decode(String.t) :: String.t
  def decode(string) when string == "", do: ""
  def decode(string) do
    string
    |> String.graphemes
    |> dec
  end
  defp dec(l, acc \\ "")
  defp dec([], acc), do: acc
  defp dec(l, acc) do
    {n, char} = Enum.reduce_while(l, "", &(if Regex.match?(~r/[0-9]/, &1), do: {:cont, &2 <> &1}, else: {:halt, {&2, &1}}))
    {acc, l} = 
      case n do
        "" -> {acc <> char, Enum.drop(l, 1)}
        _ -> {acc <> String.duplicate(char, String.to_integer(n)), Enum.drop(l, String.length(n) + 1)}
      end
    dec(l, acc)
  end
end

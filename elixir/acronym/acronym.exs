defmodule Acronym do
  @doc """
  Generate an acronym from a string.
  "This is a string" => "TIAS"
  """
  @spec abbreviate(String.t()) :: String.t()
  def abbreviate(string) do
  string
  |> String.split
  |> reduce
  end

  defp reduce([]), do: ""
  defp reduce([h | t]) do
    h = String.upcase(String.first(h)) <> String.slice(h, 1..String.length(h))
    |> String.replace(~r/[[:lower:]]/, "")
    |> String.replace(~r/[[:punct:]]/, "")
    h <> reduce(t)
  end
end

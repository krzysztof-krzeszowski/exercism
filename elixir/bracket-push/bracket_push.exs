defmodule BracketPush do
  @doc """
  Checks that all the brackets and braces in the string are matched correctly, and nested correctly
  """
  
  @valid "{}[]()"

  def check_brackets(""), do: true
  @spec check_brackets(String.t) :: boolean
  def check_brackets(str) do
    (for v <- (str |> String.graphemes), String.contains?(@valid, v), do: v)
    |> Enum.join
    |> clean

  defp clean(""), do: true
  defp clean(str) do
    new = str
    |> String.replace("()", "")
    |> String.replace("{}", "")
    |> String.replace("[]", "")
    if new === str, do: false, else: clean(new)
  end

end

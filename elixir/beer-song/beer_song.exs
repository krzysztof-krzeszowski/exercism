defmodule BeerSong do
  @doc """
  Get a single verse of the beer song
  """
  
  def verse(0), do:
    """
    No more bottles of beer on the wall, no more bottles of beer.
    Go to the store and buy some more, 99 bottles of beer on the wall.
    """
  @spec verse(integer) :: String.t
  def verse(number) do
    "#{number |> bottle |> String.capitalize} "
    [
    number |> bottle |> String.capitalize,
    " of beer on the wall, ",
    number |> bottle,
    " of beer.\n",
    "Take ",
    number |> it_or_one?,
    " down and pass it around, ",
    number - 1 |> bottle ,
    " of beer on the wall.\n"
    ]
    |> Enum.join
  end

  @doc """
  Get the entire beer song for a given range of numbers of bottles.
  """
  def lyrics(range \\ 99..0)
  @spec lyrics(Range.t) :: String.t
  def lyrics(range) do
      range
      |> Enum.map(&verse/1)
      |> Enum.join("\n")
  end

  defp bottle(0), do: "no more bottles"
  defp bottle(1), do: "1 bottle"
  defp bottle(a), do: "#{a} bottles"

  defp it_or_one?(1), do: "it"
  defp it_or_one?(_), do: "one"
end

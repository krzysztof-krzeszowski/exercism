defmodule TwelveDays do
  @doc """
  Given a `number`, return the song's verse for that specific day, including
  all gifts for previous days in the same line.
  """
  @days ["first", "second", "third", "fourth", "fifth", "sixth", "seventh", "eighth", "ninth", "tenth", "eleventh", "twelfth"]
  @gifts [
    "a Partridge in a Pear Tree",
    "two Turtle Doves",
    "three French Hens",
    "four Calling Birds",
    "five Gold Rings",
    "six Geese-a-Laying",
    "seven Swans-a-Swimming",
    "eight Maids-a-Milking",
    "nine Ladies Dancing",
    "ten Lords-a-Leaping",
    "eleven Pipers Piping",
    "twelve Drummers Drumming"
  ]

  @spec verse(number :: integer) :: String.t()
  def verse(number) do
    "On the #{Enum.at @days, number - 1} day of Christmas my true love gave to me, " <> giftlist(number) <> "."
  end

  @doc """
  Given a `starting_verse` and an `ending_verse`, return the verses for each
  included day, one per line.
  """
  @spec verses(starting_verse :: integer, ending_verse :: integer) :: String.t()
  def verses(starting_verse, ending_verse) do
    Enum.map(starting_verse..ending_verse, &(verse &1))
    |> Enum.join("\n")
  end

  @doc """
  Sing all 12 verses, in order, one verse per line.
  """
  @spec sing():: String.t()
  def sing do
    verses(1, 12)
  end

  @spec giftlist(day :: integer) :: String.t()
  defp giftlist day do
    if day == 1 do
      Enum.at(@gifts, 0)
    else
      r = day - 1..1
      |> Enum.map(&(Enum.at(@gifts, &1)))
      |> Enum.join(", ")
      r <> ", and " <> Enum.at @gifts, 0
    end
  end
end


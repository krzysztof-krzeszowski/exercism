defmodule Luhn do
  @doc """
  Calculates the total checksum of a number
  """
  @spec checksum(String.t()) :: integer
  def checksum(number) do
    number
    |> String.graphemes
    |> Enum.map(&String.to_integer/1)
    |> Enum.reverse
    |> Enum.chunk(2, 2, [])
    |> Enum.reduce(0, &(&2 + helper(&1)))
  end

  defp helper([a]), do: a
  defp helper([a, b]) when 2 * b > 9, do: 2 * b - 9 + a
  defp helper([a, b]), do: 2 * b + a

  @doc """
  Checks if the given number is valid via the luhn formula
  """
  @spec valid?(String.t()) :: boolean
  def valid?(number) do
    rem(checksum(number), 10) == 0
  end

  @doc """
  Creates a valid number by adding the correct
  checksum digit to the end of the number
  """
  def create(number, a) do
    if valid?(number <> to_string(a)),
      do: number <> to_string(a),
      else: create(number, a + 1)
  end
  @spec create(String.t()) :: String.t()
  def create(number) do
    create(number, 0)
  end
end

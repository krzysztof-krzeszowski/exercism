defmodule Phone do
  @doc """
  Remove formatting from a phone number.

  Returns "0000000000" if phone number is not valid
  (10 digits or "1" followed by 10 digits)

  ## Examples

  iex> Phone.number("123-456-7890")
  "1234567890"

  iex> Phone.number("+1 (303) 555-1212")
  "3035551212"

  iex> Phone.number("867.5309")
  "0000000000"
  """
  @spec number(String.t) :: String.t
  def number(raw) do
    raw
    |> get_numbers
    |> validate
  end

  @doc """
  Extract the area code from a phone number

  Returns the first three digits from a phone number,
  ignoring long distance indicator

  ## Examples

  iex> Phone.area_code("123-456-7890")
  "123"

  iex> Phone.area_code("+1 (303) 555-1212")
  "303"

  iex> Phone.area_code("867.5309")
  "000"
  """
  @spec area_code(String.t) :: String.t
  def area_code(raw) do
    raw
    |> get_numbers
    |> validate
    |> String.slice(0..2)
  end

  @doc """
  Pretty print a phone number

  Wraps the area code in parentheses and separates
  exchange and subscriber number with a dash.

  ## Examples

  iex> Phone.pretty("123-456-7890")
  "(123) 456-7890"

  iex> Phone.pretty("+1 (303) 555-1212")
  "(303) 555-1212"

  iex> Phone.pretty("867.5309")
  "(000) 000-0000"
  """
  @spec pretty(String.t) :: String.t
  def pretty(raw) do
    n = raw
    |> get_numbers
    |> validate
    "(#{String.slice(n, 0..2)}) #{String.slice(n, 3..5)}-#{String.slice(n, 6..10)}"
  end

  defp get_numbers raw do
    raw
    |> String.replace(~r/[() +-.]/, "")
  end

  defp validate(raw) when byte_size(raw) == 11 do
    if String.first(raw) == "1",
      do: String.slice(raw, 1..10),
      else: "0000000000"
  end
  defp validate(raw) when byte_size(raw) == 10  do
    if Regex.match?(~r/^[0-9]*$/, raw), do: raw, else: "0000000000"
  end
  defp validate(_), do: "0000000000"
end

defmodule RotationalCipher do
  @doc """
  Given a plaintext and amount to shift by, return a rotated string.

  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """

  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  def rotate(text, shift) do
    letters = String.codepoints("abcdefghijklmnopqrstuvwxyz")
    n = length(letters)
    lm = Enum.zip(letters, 0..n - 1)
    |> Enum.into(%{})
    nm = Enum.zip(0..n - 1, letters)
    |> Enum.into(%{})

    text
    |> String.codepoints
    |> Enum.map(&rot(&1, lm, nm, shift, n))
    |> to_string

  end

  defp rot(x, lm, nm, s, n) do
    xx = String.downcase x
    if Map.has_key?(lm, xx) do
      l = nm[rem(lm[xx] + s, n)]
      if String.upcase(xx) == x do
        String.upcase(l)
      else
        l
      end
    else
      x
    end
  end
end


defmodule Tournament do
  @doc """
  Given `input` lines representing two teams and whether the first of them won,
  lost, or reached a draw, separated by semicolons, calculate the statistics
  for each team's number of games played, won, drawn, lost, and total points
  for the season, and return a nicely-formatted string table.

  A win earns a team 3 points, a draw earns 1 point, and a loss earns nothing.

  Order the outcome by most total points for the season, and settle ties by
  listing the teams in alphabetical order.
  """

  @win %{mp: 1, w: 1, d: 0, l: 0, p: 3}
  @draw %{mp: 1, w: 0, d: 1, l: 0, p: 1}
  @loss %{mp: 1, w: 0, d: 0, l: 1, p: 0}
  @header "Team                           | MP |  W |  D |  L |  P"

  @spec tally(input :: list(String.t())) :: String.t()
  def tally(input, m \\ %{})
  def tally([], m), do: m |> print
  def tally([h | t], m),
    do: tally(t, update(m, h |> String.split(";")))

  defp update(m, [a, b, "win"]), do: update(m, a, @win, b, @loss)
  defp update(m, [a, b, "draw"]), do: update(m, a, @draw, b, @draw)
  defp update(m, [a, b, "loss"]), do: update(m, a, @loss, b, @win)
  defp update(m, _), do: m
  defp update(m, a, ma, b, mb) do
    m
    |> Map.merge(%{a => ma}, fn _, v1, v2 -> 
                            Map.merge(v1, v2, fn _, vv1, vv2 ->
                                                vv1 + vv2
                                              end)
                            end)
    |> Map.merge(%{b => mb}, fn _, v1, v2 -> 
                            Map.merge(v1, v2, fn _, vv1, vv2 ->
                                                vv1 + vv2
                                              end)
                            end)
  end

  defp print(m) do
    m
    |> Map.to_list
    |> Enum.sort(fn a, b ->
                  (a |> elem(1) |> Map.get(:p)) >= (b |> elem(1) |> Map.get(:p))
                end)
    |> Enum.reduce(@header, &(&2 <> get_line(&1)))
  end

  defp get_line({a, %{mp: mp, w: w, d: d, l: l, p: p}}) do
    "\n#{a |> String.ljust(30)} | #{mp |> pad} | #{w |> pad} | #{d |> pad} | #{l |> pad} | #{p |> pad}"
  end

  defp pad(v), do: v |> to_string |> String.rjust(2)
end


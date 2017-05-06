defmodule Strain do
  @doc """
  Given a `list` of items and a function `fun`, return the list of items where
  `fun` returns true.

  Do not use `Enum.filter`.
  """
  @spec keep(list :: list(any), fun :: ((any) -> boolean)) :: list(any)
  def keep(list, fun) do
    Enum.map(list, fun)
    |> Enum.zip(list)
    |> run
  end

  @doc """
  Given a `list` of items and a function `fun`, return the list of items where
  `fun` returns true.

  Do not use `Enum.reject`.
  """
  @spec discard(list :: list(any), fun :: ((any) -> boolean)) :: list(any)
  def discard(list, fun) do
    Enum.map(list, fun)
    |> Enum.map(&(!&1))
    |> Enum.zip(list)
    |> run
  end

  defp run([]), do: []
  defp run [{flag, v} | t] do
    if flag do
      [] ++ [v] ++ run t
    else
      [] ++ run t
    end
  end
end


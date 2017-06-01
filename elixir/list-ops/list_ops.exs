defmodule ListOps do
  # Please don't use any external modules (especially List) in your
  # implementation. The point of this exercise is to create these basic functions
  # yourself.
  #
  # Note that `++` is a function from an external module (Kernel, which is
  # automatically imported) and so shouldn't be used either.

  @spec count(list) :: non_neg_integer
  def count(l, acc \\ 0)
  def count([], acc), do: acc
  def count([_ | t], acc), do: count(t, acc + 1)

  def reverse(l, acc \\ [])
  def reverse([], acc), do: acc
  def reverse([h | t], acc), do: reverse(t, [h | acc])

  def map(l, f, acc \\ [])
  def map([], _, acc), do: acc |> reverse
  @spec map(list, (any -> any)) :: list
  def map([h | t], f, acc), do: map(t, f, [f.(h) | acc])

  def filter(l, f, acc \\ [])
  def filter([], _, acc), do: acc |> reverse
  @spec filter(list, (any -> as_boolean(term))) :: list
  def filter([h | t], f, acc) do
    if f.(h), do: filter(t, f, [h | acc]), else: filter(t, f, acc)
  end

  @type acc :: any
  @spec reduce(list, acc, ((any, acc) -> acc)) :: acc
  def reduce([], acc, _), do: acc
  def reduce([h | t], acc, f), do: reduce(t, f.(h, acc), f)

  def append(a, b, acc \\ [])
  def append([], [], acc), do: acc |> reverse
  def append([], a, acc), do: append(a, [], acc)
  @spec append(list, list) :: list
  def append([h | t], b, acc), do: append(t, b, [h | acc])

  def concat(l, acc \\ [])
  def concat([], acc), do: acc |> reverse
  @spec concat([[any]]) :: [any]
  def concat([[] | t], acc), do: concat(t, acc)
  def concat([[h | t] | t1], acc), do: concat([t | t1], [h | acc])
end

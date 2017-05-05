defmodule Sublist do
  @doc """
  Returns whether the first list is a sublist or a superlist of the second list
  and if not whether it is equal or unequal to the second list.
  """
  def compare(a, a), do: :equal
  def compare(_, []), do: :superlist
  def compare([], _), do: :sublist
  def compare(a, b) when length(a) == length(b), do: :unequal
  def compare(a, b) do
    {logic, type} = 
      cond do
        length(a) > length(b) -> {cmp(b, a), :superlist}
        true -> {cmp(a, b), :sublist}
      end
    if logic == true, do: type, else: :unequal
  end

  def cmp(_, []), do: false
  def cmp([a | b], [a | c]) do
    if b === Enum.slice(c, 0, length(b)), do: true, else: cmp([a | b], Enum.drop([a | c], 1))
  end
  def cmp([a | b], [c | d]), do: cmp([a | b], Enum.drop([c | d], 1))
end

defmodule LinkedList do
  @opaque t :: tuple()

  @doc """
  Construct a new LinkedList
  """
  @spec new() :: t
  def new() do
    []
  end

  @doc """
  Push an item onto a LinkedList
  """
  @spec push(t, any()) :: t
  def push(list, elem) do
    [elem | list]
  end

  @doc """
  Calculate the length of a LinkedList
  """
  @spec length(t) :: non_neg_integer()
  def length(list) do
    list
    |> Enum.reduce(0, fn _, acc -> acc + 1 end)
  end

  @doc """
  Determine if a LinkedList is empty
  """
  @spec empty?(t) :: boolean()
  def empty?(list) do
    if LinkedList.length(list) === 0, do: true, else: false
  end

  @doc """
  Get the value of a head of the LinkedList
  """
  @spec peek(t) :: {:ok, any()} | {:error, :empty_list}
  def peek(list) do
    cond do
      is_list(list) == false -> {:error, :empty_list}
      LinkedList.length(list) === 0 -> {:error, :empty_list}
      [h | _] = list -> {:ok, h}
    end
  end

  @doc """
  Get tail of a LinkedList
  """
  @spec tail(t) :: {:ok, t} | {:error, :empty_list}
  def tail(list) do
    cond do
      is_list(list) == false -> {:error, :empty_list}
      LinkedList.length(list) == 0 -> {:error, :empty_list}
      true -> {:ok, (LinkedList.pop(list) |> elem(2))}
    end
  end

  @doc """
  Remove the head from a LinkedList
  """
  @spec pop(t) :: {:ok, any(), t} | {:error, :empty_list}
  def pop(list) do
    cond do
      LinkedList.length(list) < 1 -> {:error, :empty_list}
      [h | t] = list -> {:ok, h, t}
    end
  end

  @doc """
  Construct a LinkedList from a stdlib List
  """
  @spec from_list(list()) :: t
  def from_list(list) do
    l = LinkedList.new()
    list
    |> Enum.reduce(l, &(LinkedList.push(&2, &1)))
    |> LinkedList.reverse 
  end

  @doc """
  Construct a stdlib List LinkedList from a LinkedList
  """
  @spec to_list(t) :: list()
  def to_list(list) do
    LinkedList.from_list list
  end

  @doc """
  Reverse a LinkedList
  """
  @spec reverse(t) :: t
  def reverse(list) do
    list |> Enum.reverse
  end
end

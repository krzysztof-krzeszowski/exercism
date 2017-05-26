defmodule Matrix do
  defstruct matrix: %{vals: nil, n_rows: nil, n_cols: nil}

  @doc """
  Convert an `input` string, with rows separated by newlines and values
  separated by single spaces, into a `Matrix` struct.
  """
  @spec from_string(input :: String.t()) :: %Matrix{}
  def from_string(input) do
    rows = input
    |> String.split("\n")
    n_rows = rows |> length
    vals = rows
    |> Enum.reduce([], &(&2 ++ String.split(&1)))
    |> Enum.map(&String.to_integer/1)
    %{vals: vals, n_rows: n_rows, n_cols: div(vals |> length, n_rows)}
  end

  @doc """
  Write the `matrix` out as a string, with rows separated by newlines and
  values separated by single spaces.
  """
  @spec to_string(matrix :: %Matrix{}) :: String.t()
  def to_string(matrix) do
  matrix.vals
  |> Enum.chunk(matrix.n_cols)
  |> Enum.map(&(Enum.join(&1, " ")))
  |> Enum.join("\n")
  end

  @doc """
  Given a `matrix`, return its rows as a list of lists of integers.
  """
  @spec rows(matrix :: %Matrix{}) :: list(list(integer))
  def rows(matrix) do
    matrix.vals
    |> Enum.chunk(matrix.n_cols)
  end

  @doc """
  Given a `matrix` and `index`, return the row at `index`.
  """
  @spec row(matrix :: %Matrix{}, index :: integer) :: list(integer)
  def row(matrix, index) do
    matrix
    |> rows
    |> Enum.at(index)
  end

  @doc """
  Given a `matrix`, return its columns as a list of lists of integers.
  """
  @spec columns(matrix :: %Matrix{}) :: list(list(integer))
  def columns(matrix) do
    for v <- 1..matrix.n_cols,
    do: Enum.drop(matrix.vals, v - 1) |> Enum.take_every(matrix.n_cols)
  end

  @doc """
  Given a `matrix` and `index`, return the column at `index`.
  """
  @spec column(matrix :: %Matrix{}, index :: integer) :: list(integer)
  def column(matrix, index) do
    matrix
    |> columns
    |> Enum.at(index)
  end
end


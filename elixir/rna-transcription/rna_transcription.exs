defmodule RNATranscription do
  @doc """
  Transcribes a character list representing DNA nucleotides to RNA

  ## Examples

  iex> RNATranscription.to_rna('ACTG')
  'UGAC'
  """
  @trans %{?A => ?U, ?C => ?G, ?T => ?A, ?G => ?C}

  @spec to_rna([char]) :: [char]
  def to_rna(dna) do
    dna |> Enum.map(&(@trans[&1]))
  end
end

defmodule ProteinTranslation do
  @doc """
  Given an RNA string, return a list of proteins specified by codons, in order.
  """
  @spec of_rna(String.t()) :: { atom,  list(String.t()) }
  def of_rna(rna) do
    v = rna
    |> slice3
    |> Enum.map(&(of_codon &1))
    if Enum.member? v, {:error, "invalid codon"} do
      {:error, "invalid RNA"}
    else
      v = v
      |> Enum.map(&(elem(&1, 1)))
      |> Enum.split_while(&(&1 !== "STOP"))
      |> elem(0)
      {:ok, v}
    end
  end

  @doc """
  Given a codon, return the corresponding protein

  UGU -> Cysteine
  UGC -> Cysteine
  UUA -> Leucine
  UUG -> Leucine
  AUG -> Methionine
  UUU -> Phenylalanine
  UUC -> Phenylalanine
  UCU -> Serine
  UCC -> Serine
  UCA -> Serine
  UCG -> Serine
  UGG -> Tryptophan
  UAU -> Tyrosine
  UAC -> Tyrosine
  UAA -> STOP
  UAG -> STOP
  UGA -> STOP
  """
  @trans %{
  "UGU" => "Cysteine",
  "UGC" => "Cysteine",
  "UUA" => "Leucine",
  "UUG" => "Leucine",
  "AUG" => "Methionine",
  "UUU" => "Phenylalanine",
  "UUC" => "Phenylalanine",
  "UCU" => "Serine",
  "UCC" => "Serine",
  "UCA" => "Serine",
  "UCG" => "Serine",
  "UGG" => "Tryptophan",
  "UAU" => "Tyrosine",
  "UAC" => "Tyrosine",
  "UAA" => "STOP",
  "UAG" => "STOP",
  "UGA" => "STOP"
  }
  @spec of_codon(String.t()) :: { atom, String.t() }
  def of_codon(codon) do
    if Map.has_key? @trans, codon do
      {:ok, @trans[codon]}
    else
      {:error, "invalid codon"}
    end
  end

  defp slice3(""), do: []
  defp slice3 str do
    [String.slice(str, 0..2)] 
    ++ slice3(String.slice(str, 3, 999))
  end
end


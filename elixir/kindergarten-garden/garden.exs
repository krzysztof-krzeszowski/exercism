defmodule Garden do
  @doc """
    Accepts a string representing the arrangement of cups on a windowsill and a
    list with names of students in the class. The student names list does not
    have to be in alphabetical order.

    It decodes that string into the various gardens for each student and returns
    that information in a map.
  """

  @names [:alice, :bob, :charlie, :david, :eve, 
          :fred, :ginny, :harriet, :ileana, :joseph, :kincaid, :larry]

  @plants %{"C" => :clover, "G" => :grass, "R" => :radishes, "V" => :violets}

  @spec info(String.t(), list) :: map
  def info(info_string, student_names \\ @names) do
    info_string
    |> get_plants
    |> assign_to_students(student_names |> Enum.sort)
  end

  defp get_plants(str) do
    str
    |> String.split("\n")
    |> Enum.map(&String.graphemes/1)
    |> group_plants
  end

  defp group_plants([[], []]), do: []
  defp group_plants([[a1, a2 | ta], [b1, b2 | tb]]) do
    [[a1, a2, b1, b2] |> Enum.map(&(Map.get(@plants, &1))) |> List.to_tuple] ++ group_plants([ta, tb])
  end

  defp assign_to_students(plants, students) do
    students
    |> Enum.reduce(
        Enum.zip(students, plants) |> Map.new,
        &(Map.update(&2, &1, {}, fn v -> v end))
    )
  end
end

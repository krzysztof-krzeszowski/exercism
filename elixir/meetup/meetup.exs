defmodule Meetup do
  @moduledoc """
  Calculate meetup dates.
  """

  @type weekday ::
      :monday | :tuesday | :wednesday
    | :thursday | :friday | :saturday | :sunday

  @type schedule :: :first | :second | :third | :fourth | :last | :teenth

  @weekdays %{monday: 1, tuesday: 2, wednesday: 3, thursday: 4,
              friday: 5, saturday: 6, sunday: 7}

  @doc """
  Calculate a meetup date.

  The schedule is in which week (1..4, last or "teenth") the meetup date should
  fall.
  """
  @spec meetup(pos_integer, pos_integer, weekday, schedule) :: :calendar.date
  def meetup(year, month, weekday, schedule) do
    {
      year, 
      month, 
      Date.new(year, month, 1)
        |> elem(1)
        |> Date.day_of_week
        |> (&(rem 7 - &1 + Map.get(@weekdays, weekday) + 1, 7)).()
        |> helper
        |> translate(year, month, schedule)
    }
  end

  defp helper(0), do: 7
  defp helper(a), do: a

  defp helper2([a, b]) when a + 7 > b, do: a
  defp helper2([a, _]), do: a + 7

  defp translate(d, _, _, :first), do: d
  defp translate(d, _, _, :second), do: d + 7
  defp translate(d, _, _, :third), do: d + 14
  defp translate(d, _, _, :fourth), do: d + 21
  defp translate(d, _, _, :teenth) do
    [translate(d, 0, 0, :second), 19]
    |> helper2
  end
  defp translate(d, y, m, :last) do
    [
      translate(d, 0, 0, :fourth), 
      Date.new(y, m, 1) |> elem(1) |> Date.days_in_month
    ]
    |> helper2
  end
end

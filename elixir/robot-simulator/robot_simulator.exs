defmodule RobotSimulator do
  @doc """
  Create a Robot Simulator given an initial direction and position.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  
  @dir [:north, :east, :south, :west]

  @spec create(direction :: atom, position :: { integer, integer }) :: any
  def create(direction \\ :north, position \\ {0, 0})
  def create(direction, _) when Kernel.not(direction in @dir), do: {:error, "invalid direction"}
  def create(direction, {x, y}) when is_integer(x) and is_integer(y) do
    {x, y, Enum.find_index(@dir, &(&1 == direction))}
  end
  def create(_, _), do: {:error, "invalid position"}

  @doc """
  Simulate the robot's movement given a string of instructions.

  Valid instructions are: "R" (turn right), "L", (turn left), and "A" (advance)
  """
  @spec simulate(robot :: any, instructions :: String.t ) :: any
  def simulate(robot, instructions) do
    instructions
    |> String.graphemes
    |> Enum.reduce(robot, &(move(&2, &1)))
  end

  def move({x, y, a}, "L"), do: {x, y, rem(4 + a - 1, 4)}
  def move({x, y, a}, "R"), do: {x, y, rem(4 + a + 1, 4)}
  def move({x, y, a}, "A") do
    {
      x + :math.sin(0.5 * a * :math.pi) |> round,
      y + :math.cos(0.5 * a * :math.pi) |> round,
      a
    }
  end
  def move(_, _), do: {:error, "invalid instruction"}

  @doc """
  Return the robot's direction.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec direction(robot :: any) :: atom
  def direction({:error, msg}), do: {:error, msg}
  def direction({_, _, direction}), do: Enum.at(@dir, direction)

  @doc """
  Return the robot's position.
  """
  @spec position(robot :: any) :: { integer, integer }
  def position({:error, msg}), do: {:error, msg}
  def position({x, y, _}) do
    {x, y}
  end
end

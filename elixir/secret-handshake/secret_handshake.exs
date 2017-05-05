defmodule SecretHandshake do
  @doc """
  Determine the actions of a secret handshake based on the binary
  representation of the given `code`.

  If the following bits are set, include the corresponding action in your list
  of commands, in order from lowest to highest.

  1 = wink
  10 = double blink
  100 = close your eyes
  1000 = jump

  10000 = Reverse the order of the operations in the secret handshake
  """
  @spec commands(code :: integer) :: list(String.t())
  def commands(code) do
    list = ["wink", "double blink", "close your eyes", "jump"]
    b = Integer.to_string(code, 2)
    b = String.rjust(b, 5, ?0)
    b = String.split(b, "", trim: true)
    [reverse | code ] = b
    code = Enum.reverse code
    result = Enum.zip list, code 
    result = for e <- result, elem(e, 1) === "1", do: elem(e, 0)
    if reverse === "1" do
      Enum.reverse result
    else
      result
    end
  end
end


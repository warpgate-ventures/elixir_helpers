defmodule ElixirHelpersTest do
  use ExUnit.Case
  doctest ElixirHelpers

  test "greets the world" do
    assert ElixirHelpers.hello() == :world
  end
end

defmodule BreweryServerTest do
  use ExUnit.Case
  doctest BreweryServer

  test "greets the world" do
    assert BreweryServer.hello() == :world
  end
end

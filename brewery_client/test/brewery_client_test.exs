defmodule BreweryClientTest do
  use ExUnit.Case
  doctest BreweryClient

  test "greets the world" do
    assert BreweryClient.hello() == :world
  end
end

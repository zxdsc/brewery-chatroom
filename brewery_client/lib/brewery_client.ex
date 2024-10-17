defmodule BreweryClient do
  use Application

  @impl true
  def start(_type, _args) do
    IO.gets("Port to connect to \n")
      |> String.trim
      |> String.to_integer
      |> connect
  end

  def connect(port) do
    {:ok, socket} = :gen_tcp.connect({127, 0, 0, 1}, port, [])
    :gen_tcp.send(socket, "test connection")
  end
end

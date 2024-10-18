defmodule BreweryClient do
  require Logger
  use Application

  @impl true
  def start(_type, _args) do
    IO.gets("Port to connect to \n")
    |> String.trim()
    |> String.to_integer()
    |> connect
  end

  def connect(port) do
    with {:ok, socket} <- :gen_tcp.connect({127, 0, 0, 1}, port, [active: false]),
         {:ok, msg} <- :gen_tcp.recv(socket, 0),
         IO.puts(msg),
         nick = IO.gets("\n") do
      :gen_tcp.send(socket, nick)
    end
  end
end

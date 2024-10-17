defmodule BreweryServer do
  use Application
require Logger

  def start(_type, _args) do
    port = Enum.random(1024..49_151)
    Logger.info("Server starting on port: #{port}")
    listen(port)
  end

  def listen(port) do
    case :gen_tcp.listen(port, [active: false]) do
      {:ok, listen_socket} ->
        Logger.info("Server listening on port: #{port}")
         accept_message(listen_socket)
      {:error, reason} -> Logger.error("Could not listen: #{reason}")
    end
  end

  def accept_message(listen_socket) do
    {:ok, pid} = Acceptor.start_link(listen_socket)
    Acceptor.accept(pid)
  end
end

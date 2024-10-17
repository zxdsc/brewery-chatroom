defmodule Acceptor do
  require Logger
  use GenServer

  # Client
  def start_link(listen_socket) do
    GenServer.start(__MODULE__, listen_socket)
  end

  def accept(pid) do
    GenServer.cast(pid, :accept)
    accept(pid)
  end

  # Server
  @impl true
  def init(listen_socket) do
    {:ok, listen_socket}
  end

  @impl true
  def handle_cast(:accept, listen_socket) do
    {:ok, socket} = :gen_tcp.accept(listen_socket)
    {:ok, content} = :gen_tcp.recv(socket, 0)
    Logger.debug("received message: #{content}")
  end
end

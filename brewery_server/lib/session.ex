defmodule Session do
  require Logger
  use GenServer

  # Client
  def start_link(listen_socket) do
    GenServer.start_link(__MODULE__, listen_socket)
  end

  def accept(pid) do
    GenServer.cast(pid, :accept)
  end

  # Server
  @impl true
  def init(socket) do
    {:ok, %{socket: socket, nickname: ""}}
  end

  @impl true
  def handle_cast(:accept, state) do
    nickname = handle_greetings(state[:socket])
    {:noreply, %{state | nickname: nickname}}
  end

  defp handle_greetings(socket) do
    with :ok <- :gen_tcp.send(socket, "What is your nickname?"),
         {:ok, nickname} <- :gen_tcp.recv(socket, 0) do
      Logger.debug("received message: #{nickname}")
      nickname
    end
  end
end

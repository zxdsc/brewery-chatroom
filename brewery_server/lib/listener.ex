defmodule Listener do
  use GenServer

  # Client

  def start_link(port) do
    GenServer.start_link(__MODULE__, port)
  end

  def listen(pid) do
    GenServer.cast(pid, :listen)
  end

  # Server

  @impl true
  def init(port) do
    {:ok, }
    case :gen_tcp.listen(port, [active: false]) do
      {:ok, listen_socket} -> {:ok, %{sessions: [], listen_socket: listen_socket}}
      {:error, reason} -> {:stop, "Failed to listen socket. Reason: #{reason}"}
    end
  end

  @impl true
  def handle_cast(:listen, state) do
    session_pid = with {:ok, socket} <- :gen_tcp.accept(state[:listen_socket]) do
        {:ok, session_pid} = Session.start_link(socket)
        Session.accept(session_pid)
        session_pid
    end
    {:noreply, %{state | sessions: [state[:sessions] | session_pid]}}
  end
end

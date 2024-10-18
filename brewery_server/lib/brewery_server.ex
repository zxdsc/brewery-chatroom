defmodule BreweryServer do
  use Application
require Logger

  def start(_type, _args) do
    port = Enum.random(1024..49_151)
    Logger.info("Server starting on port: #{port}")
    {:ok, listener_pid} = Listener.start_link(port)
    Listener.listen(listener_pid)
    loop(listener_pid)
  end

  defp loop(pid) do
    Process.sleep(5)
    Listener.listen(pid)
    loop(pid)
  end
end

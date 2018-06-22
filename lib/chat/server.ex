defmodule Chat.Server do
  use GenServer
  require Logger

  # API

  def start_link(room_name) do
    Logger.info("server #{room_name} starting")
#    GenServer.start_link(__MODULE__, [], name: via_tuple(name))
    GenServer.start_link(__MODULE__, [], name: {:via, Registry, {:room_registry, room_name}})
  end

  def add_message(room_name, message) do
    GenServer.cast(via_tuple(room_name), {:add_message, message})
  end

  def get_messages(room_name) do
    GenServer.call(via_tuple(room_name), :get_messages)
  end

  defp via_tuple(room_name) do
    # And the tuple always follow the same format:
    # {:via, module_name, term}
    #{:via, Chat.Registry, {:chat_room, room_name}}
    {:via, Registry, {:room_registry, room_name}}
  end

  # SERVER

  def init(messages) do
    {:ok, messages}
  end

  def handle_cast({:add_message, new_message}, messages) do
    {:noreply, [new_message | messages]}
  end

  def handle_call(:get_messages, _from, messages) do
    {:reply, messages, messages}
  end
end

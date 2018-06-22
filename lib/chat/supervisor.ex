defmodule Chat.Supervisor do
  use Supervisor

  def start_link do
    Supervisor.start_link(__MODULE__, [], name: :chat_supervisor)
  end

  def start_room(name) do
    Supervisor.start_child(:chat_supervisor, %{id: name, start: {Chat.Server, :start_link, [ name ]}})
  end

  def init(_) do
    children = [
#	Chat.Server
     #  %{id: Chat.Server, start: {Chat.Server, :start_link, [[]]}}
       	{Registry, keys: :unique, name: :room_registry},
      #      %{id: Chat.Server, start: {Chat.Server, :start_link, []}}
      #      %{id: RoomRegistry, start: {Registry, keys: :unique, name: RoomRegistry}},
    ]

    Supervisor.init(children, strategy: :one_for_one)
    #Supervisor.init([], strategy: :one_for_one)
  end
end

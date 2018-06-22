# Chat

A registry/supervisor setup copied from Brian Storti's [blog](https://www.brianstorti.com/process-registry-in-elixir/).

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `chat` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:chat, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/chat](https://hexdocs.pm/chat).

## Test it in iex

    Chat.Supervisor.start_link
    Chat.Supervisor.start_room("room1")
    Chat.Supervisor.start_room("room2")
    Chat.Server.add_message("room1", "first message")
    Chat.Server.add_message("room2", "second message")
    Chat.Server.get_messages("room1")
    Chat.Server.get_messages("room2")
    Registry.whereis_name({:room_registry, "room1"}) |> Process.exit(:kill)
    Chat.Server.add_message("room1", "message2")
    Chat.Server.get_messages("room1")


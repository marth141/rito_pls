# RitoPls

The idea with this tool is to be able to look up a league of legends summoner name and region and to be able to get their last 5 matches and with a list of who all was in the game, monitor those players for new matches every minute for the next hour.

This idea challenged what I knew at the time. An approach I'd take for solving this one would be to set up a dynamic supervisor and registry. With this, I'd register a GenServer to the registry and run it under the supervisor where the GenServer will be for monitoring all of the players. List of players -> List of player monitor GenServers.

Each GenServer would then monitor for matches and where matches occur, will store them to its database.

Having thought about it, Assuming it's a regular 5v5 match, I would think that about 45 players would be monitored per any given summoner. This is assuming the input summoner name plays with randoms each match. The input summoner would be the same in 5 matches while the other 9 players should be unique for the most part. If the player is playing in duos or full teams, it would be monitoring up to 25 players per match. If it's a 5v5 with 10 of the same people in all 5 matches, then only 10 players would be monitored.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `rito_pls` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:rito_pls, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/rito_pls>.


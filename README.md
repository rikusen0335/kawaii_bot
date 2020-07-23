# KawaiiBot

My own sugoi kawaii discord bot.

## Installation

To use this bot:
- Install Elixir
- Make `dev.secret.exs` and edit it like below

```elixir
import Mix.Config

config :nostrum,
  token: "YOUR TOKEN", # The token of your bot as a string
  num_shards: :auto # The number of shards you want to run your bot under, or :auto.
```

- Do `mix deps.get`
- Do `mix run --no-halt` or `iex -S mix`
- And you're ready to go!

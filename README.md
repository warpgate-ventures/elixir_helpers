# ElixirHelpers

Collection of elixir helpers we use in Warpgate for our internal projects. Do not use this in a production app as this is currently being developed and may break your current app.

## Installation

```elixir
def deps do
  [
    {:elixir_helpers, github: "https://github.com/warpgate-ventures/elixir_helpers"},
  ]
end
```

## Usage

Adding changeset errors in your GraphQL schema.

```elixir
defmodule Schema do
  # ...


  def middleware(middleware, _field, %{identifier: :mutation}) do
    middleware ++ [ElixirHelpers.Absinthe.HandleChangesetErrors]
  end

  def middleware(middleware, _field, _object), do: middleware
end
```
defmodule ElixirHelpers.Absinthe.HandleChangesetErrors do
  @moduledoc """
  Used for handling changeset errors in GraphQL projects
  """
  @behaviour Absinthe.Middleware

  def call(resolution, _) do
    %{resolution | errors: Enum.flat_map(resolution.errors, &handle_error/1)}
  end

  defp handle_error(%Ecto.Changeset{} = changeset) do
    changeset
    |> Ecto.Changeset.traverse_errors(fn {msg, opts} ->
      Enum.reduce(opts, msg, fn {key, value}, acc ->
        String.replace(acc, "%{#{key}}", to_string(value))
      end)
    end)
    |> Enum.reduce(%{}, &flatten/2)
    |> Enum.map(&translate_error/1)
  end

  defp handle_error(error), do: [error]

  defp flatten({_k, %{} = v}, prev) do
    Enum.reduce(v, prev, &flatten/2)
  end

  defp flatten({k, v}, prev) do
    Map.put(prev, k, v)
  end

  defp translate_error({k, v}) do
    v = Enum.join(v, ", ")
    "#{k}: #{translate_error(v)}"
  end

  defp translate_error(f), do: f
end

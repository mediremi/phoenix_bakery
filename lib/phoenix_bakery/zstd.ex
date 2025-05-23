defmodule PhoenixBakery.Zstd do
  @external_resource "README.md"
  @moduledoc File.read!("README.md")
             |> String.split(~r/<!--\s*(start|end):#{inspect(__MODULE__)}\s*-->/, parts: 3)
             |> Enum.at(1)

  @behaviour Phoenix.Digester.Compressor

  @default_opts %{
    level: 22
  }

  import PhoenixBakery

  require Logger

  @impl true
  def file_extensions, do: ~w[.zst]

  @impl true
  def compress_file(file_path, content) do
    if gzippable?(file_path) do
      compress(content)
    else
      :error
    end
  end

  defp compress(content) do
    case encode(content) do
      {:ok, compressed} when byte_size(compressed) < byte_size(content) ->
        {:ok, compressed}

      _ ->
        :error
    end
  end

  defp encode(content) do
    options = options(:zstd, @default_opts)

    cond do
      Code.ensure_loaded?(:ezstd) and function_exported?(:ezstd, :compress, 2) ->
        {:ok, apply(:ezstd, :compress, [content, options.level])}

      path = find_executable(:zstd) ->
        run(:zstd, content, path, ~w[-c --ultra -#{options.level}])

      true ->
        raise "No `zstd` utility"
    end
  end
end

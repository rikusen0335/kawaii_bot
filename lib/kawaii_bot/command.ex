defmodule KawaiiBot.Command do

  alias Nostrum.Api
  alias KawaiiBot.{Help}

  @prefix Application.get_env(:kawaii_bot, :prefix)

  defp actionable_command?(message) do
    if message.author.bot == nil do
      true
    end
  end

  def handle(message) do
    if actionable_command?(message) do
      message.content
      |> String.trim
      |> String.split
      |> execute(message)
    end
  end

  def execute([@prefix], message), do: Help.help(message)
  def execute([@prefix, _], message), do: Help.help(message)
  def execute(_, _message), do: :ignore
end

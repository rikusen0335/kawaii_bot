defmodule KawaiiBot do
  use Nostrum.Consumer

  alias Nostrum.Api
  alias KawaiiBot.{Command, Utils, ErrorHandler}

  def start_link do
    Consumer.start_link(__MODULE__)
  end

  def handle_event({:MESSAGE_CREATE, message, _ws_state}) do
    cond do
      String.starts_with?(message.content, "https://discordapp.com/channels") ->
        split = String.split(message.content, "/")
        embed = Utils.link_to_msg(Enum.at(split, 4), Enum.at(split, 5), Enum.at(split, 6))
        IO.inspect(embed)
        Api.create_message!(message, embed: embed)

      !Enum.empty?(message.embeds) ->
        IO.inspect(message.embeds)
        Utils.get_image_from_embed(message.embeds)
        |> Enum.map(
            fn image_url ->
              Utils.save_image(image_url)
              Api.create_message(message, file: "/tmp/kawaii_bot_image.png")
          end)

      true ->
        Command.handle(message)
    end
  end

  def handle_event(_event) do
    :noop
  end
end

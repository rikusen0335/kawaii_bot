defmodule KawaiiBot.Utils do
  alias Nostrum.{Api, Struct.User, Struct.Guild}
  import Nostrum.Struct.Embed

  def link_to_msg(guild_id, channel_id, message_id) do
    guild_id = Integer.parse(guild_id) |> elem(0)
    channel_id = Integer.parse(channel_id) |> elem(0)
    message_id = Integer.parse(message_id) |> elem(0)

    {:ok, guild} = Api.get_guild(guild_id)
    {:ok, channel} = Api.get_channel(channel_id)
    {:ok, message} = Api.get_channel_message(channel_id, message_id)

    url = "https://cdn.discordapp.com/"
    guild_url   = url <> "channels/" <> Integer.to_string(guild_id)
    channel_url = guild_url <> "/" <> Integer.to_string(channel_id)
    message_url = channel_url <> "/" <> Integer.to_string(message_id)

    %Nostrum.Struct.Embed{}
      |> put_author(message.author.username <> "#" <> message.author.discriminator, "", User.avatar_url(message.author))
      |> put_description("#{message.content}\n**　**")
      |> put_field("メッセージ詳細",
        "サーバー - [#{guild.name}](#{guild_url})
         チャンネル - [##{channel.name}](#{channel_url})
         メッセージ - [#{message.author.username}から](#{message_url})"
      )
      |> put_footer(guild.name, Guild.icon_url(guild))
      |> put_timestamp(message.timestamp)
  end

  def get_image_from_embed(embeds) do
    images = []
    Enum.filter(embeds, fn embed -> embed.image != nil end)
      |> Enum.map(fn embed -> [embed.image.url | images] end)
  end

  def save_image(url) do
    %HTTPoison.Response{body: body} = HTTPoison.get!(url)
    File.write!("/tmp/kawaii_bot_image.png", body)
  end
end

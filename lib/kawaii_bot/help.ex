defmodule KawaiiBot.Help do

  alias Nostrum.Api

  import Nostrum.Struct.Embed

  @prefix Application.get_env(:kawaii_bot, :prefix)

  def help(message) do
    {:ok, private} = Api.create_dm(message.author.id)
    embed =
      %Nostrum.Struct.Embed{}
      |> put_title("コマンドリスト")
      |> put_field(@prefix <> " name <名前>", "チャンネルの名前を変更します")
      |> put_field(@prefix <> " help", "このヘルプリストを送ります")

    Api.create_message!(private.id, embed: embed)
  end
end

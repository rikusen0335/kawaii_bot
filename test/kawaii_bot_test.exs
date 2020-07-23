defmodule KawaiiBotTest do
  use ExUnit.Case
  doctest KawaiiBot

  test "greets the world" do
    assert KawaiiBot.hello() == :world
  end
end

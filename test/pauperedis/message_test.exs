defmodule PauperedisTest.MessageTest do
  use ExUnit.Case
  doctest Pauperedis

  alias Pauperedis.Message

  setup do
    # Set key "foo" to "barr"
    raw_bytes = <<0x00, 0x00, 0x00, 0x0C, 0x01, 0x00, 0x03, 0x66, 0x6F, 0x6F, 0x00, 0x04, 0x62, 0x61, 0x72, 0x72>>
    {:ok, message: %Message{raw: raw_bytes}}
  end

  test "message length", %{message: message} do
    m = message |> Message.decode_length
    assert 12 == m.length
  end

  test "command", %{message: message} do
    m = message |> Message.decode_length |> Message.decode_command
    assert "SET" == m.command
  end

  test "key length", %{message: message} do
    m = message |> Message.decode_length |> Message.decode_command |> Message.decode_key_length
    assert 3 == m.key_length
  end

  test "key", %{message: message} do
    m = message |> Message.decode_length |> Message.decode_command |> Message.decode_key_length |> Message.decode_key
    assert "foo" == m.key
  end

end

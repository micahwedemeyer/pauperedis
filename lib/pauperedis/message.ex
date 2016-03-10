defmodule Pauperedis.Message do
  defstruct raw: nil, length: 0, command: nil, key_length: 0, key: nil, value_length: 0, value: nil

  def decode_length(message) do
    %{message | length: binary_part(message.raw, 0, 4) |> bin_to_int}
  end

  def decode_command(message) do
    cmd = case bin_to_int(binary_part(message.raw, 4, 1)) do
      1 ->
        "SET"
      2 ->
        "GET"
    end

    %{message | command: cmd}
  end

  def decode_key_length(message) do
    %{message | key_length: binary_part(message.raw, 5, 2) |> bin_to_int}
  end

  def decode_key(message) do
    %{message | key: binary_part(message.raw, 7, message.key_length)}
  end

  def decode_value_length(message) do
    len = binary_part(message.raw, value_length_start(message), 2) |> bin_to_int
    %{message | value_length: len}
  end

  def decode_value(message) do
    val = binary_part(message.raw, value_start(message), message.value_length)
    %{message | value: val}
  end

  defp bin_to_int(bin) do
    bytes = byte_size(bin)
    bin_tup = :binary.bin_to_list(bin) |> Enum.reverse |> List.to_tuple

    v = Enum.reduce(0..(bytes - 1), 0, fn(i, acc) ->
      acc + (:math.pow(2, 8 * i) * elem(bin_tup, i))
    end)

    round(v)
  end

  defp value_length_start(message) do
    7 + message.key_length
  end

  defp value_start(message) do
    value_length_start(message) + 2
  end
end
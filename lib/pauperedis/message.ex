defmodule Pauperedis.Message do
  defstruct raw: nil, length: 0, command: nil, key_length: 0, key: nil, value_length: 0, value: nil

  def decode_length(message) do
    bin = binary_part(message.raw, 0, 4)
    len = bin_to_int(bin)

    %{message | length: len}
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

  defp bin_to_int(bin) do
    bytes = byte_size(bin)
    bin_tup = :binary.bin_to_list(bin) |> Enum.reverse |> List.to_tuple

    v = Enum.reduce(0..(bytes - 1), 0, fn(i, acc) ->
      acc + (:math.pow(2, 8 * i) * elem(bin_tup, i))
    end)

    round(v)
  end
end
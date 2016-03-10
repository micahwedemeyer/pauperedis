defmodule Pauperedis.Message do
  defstruct raw: nil, length: 0, command: nil, key_length: 0, key: nil, value_length: 0, value: nil

  def decode_length(message) do
    len_tup = :binary.bin_to_list(message.raw, 0, 4) |> Enum.reverse |> List.to_tuple

    len = Enum.reduce(0..3, 0, fn(i, acc) ->
      acc + (:math.pow(2, 8 * i) * elem(len_tup, i))
    end)

    %{message | length: len}
  end
end
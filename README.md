# Pauperedis

A poor man's redis.

## Commands

### SET message:
4 byte for the total size of the message in network byte order
1 byte for the command, 1 for set
2 bytes for the key_length
key_length bytes for the key as a string
2 bytes for the value_length
value_length bytes for the value as a string

### GET message:
4 byte for the total size of the message in network byte order
1 byte for the command, 2 for get
2 bytes for the key_length
key_length bytes for the key as a string

### GET responds with a message to the client:
4 byte for the total size of the message in network byte order
message_size bytes for the value

### Example SET:
Set key "foo" to "barr"
0x00 0x00 0x00 0x0C 0x01 0x00 0x03 0x66 0x6F 0x6F 0x00 0x04 0x62 0x61 0x72 0x72

    [0x00 0x00 0x00 0x0C] - 12 bytes for the message (don't count the first 4 bytes)
    [0x01] - SET command
    [0x00 0x03] - Key length of 3 bytes
    [0x66 0x6F 0x6F] - "foo"
    [0x00 0x04] - Value length of 4 bytes
    [0x62 0x61 0x72 0x72] - "barr"


## Example GET:
Get key "foo"
0x00 0x00 0x00 0x06 0x02 0x00 0x03 0x66 0x6F 0x6F

    [0x00 0x00 0x00 0x06] - 6 bytes for the message (don't count first 4)
    [0x02] - GET command
    [0x00 0x03] - Key length of 3 bytes
    [0x66 0x6F 0x6F] - "foo"

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  1. Add pauperedis to your list of dependencies in `mix.exs`:

        def deps do
          [{:pauperedis, "~> 0.0.1"}]
        end

  2. Ensure pauperedis is started before your application:

        def application do
          [applications: [:pauperedis]]
        end


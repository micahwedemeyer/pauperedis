# Pauperedis

A poor man's redis.

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


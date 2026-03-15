app [main!] { cli: platform "https://github.com/roc-lang/basic-cli/releases/download/0.20.0/X73hGh05nNTkDHU06FHC0YfFaQB1pimX7gncRcao5mU.tar.br" }

import cli.Stdout
import cli.Arg exposing [Arg]

import Database
import ZulipGlue

test_insert =
    channel = { channel_id: 101, name: "Engineering" }
    db = Database.new

    db |> Database.insert_channel(channel)

test_process =
    db = Database.new
    subscription = { stream_id: 201, name: "Design" }
    ZulipGlue.process_server_subscription(db, subscription)

main! : List Arg => Result {} _
main! = |_args|
    dbg test_insert
    dbg test_process

    Stdout.line!("")

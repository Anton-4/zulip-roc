app [main!] { cli: platform "https://github.com/roc-lang/basic-cli/releases/download/0.20.0/X73hGh05nNTkDHU06FHC0YfFaQB1pimX7gncRcao5mU.tar.br" }

import cli.Stdout
import cli.Arg exposing [Arg]

import Database
import ZulipGlue

test_insert_channel =
    channel = { channel_id: 101, name: "Engineering" }
    Database.new |> Database.insert_channel(channel)

test_insert_message =
    message = {
        channel_id : 99,
        content : "some content",
        message_id: 1001,
        sender_id : 99,
        topic_id : 99,

    }
    Database.new |> Database.insert_message(message)

test_process =
    db = Database.new
    subscription = { stream_id: 201, name: "Design" }
    ZulipGlue.process_server_subscription(db, subscription)

main! : List Arg => Result {} _
main! = |_args|
    dbg test_insert_channel
    dbg test_insert_message
    dbg test_process

    Stdout.line!("")

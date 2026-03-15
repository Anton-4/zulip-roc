app [main!] { cli: platform "https://github.com/roc-lang/basic-cli/releases/download/0.20.0/X73hGh05nNTkDHU06FHC0YfFaQB1pimX7gncRcao5mU.tar.br" }

import cli.Stdout
import cli.Arg exposing [Arg]

import Database
import ZulipGlue
import TopicHelper

test_insert_channel =
    channel = { channel_id: 101, name: "Engineering" }
    Database.new |> Database.insert_channel(channel)

test_insert_message =
    message = {
        channel_id: 99,
        content: "some content",
        message_id: 1001,
        sender_id: 99,
        topic_id: 99,
    }
    Database.new |> Database.insert_message(message)

test_process_server_subscription =
    subscription = { stream_id: 201, name: "Design" }
    Database.new |> ZulipGlue.process_server_subscription(subscription)

test_process_server_message =
    message = {
        content: "some content",
        id: 1001,
        sender_full_name: "Foo Barson",
        sender_id: 1,
        subject: "some topic",
        stream_id: 101,
        type: "stream",
    }
    Database.new |> ZulipGlue.process_server_message(message, TopicHelper.new)

main! : List Arg => Result {} _
main! = |_args|
    dbg test_insert_channel
    dbg test_insert_message
    dbg test_process_server_subscription
    dbg test_process_server_message

    Stdout.line!("")

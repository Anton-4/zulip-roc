app [main!] { cli: platform "https://github.com/roc-lang/basic-cli/releases/download/0.20.0/X73hGh05nNTkDHU06FHC0YfFaQB1pimX7gncRcao5mU.tar.br" }

import cli.Stdout
import cli.Arg exposing [Arg]
import TopicHelper

main! : List Arg => Result {} _
main! = |_args|
    _ = Stdout.line!("\n\n--------------\n\n")

    msgs = [
        { channel_id: 101, subject: "fred", content: "msg1" },
        { channel_id: 101, subject: "fred", content: "msg2" },
        { channel_id: 101, subject: "mary", content: "msg3" },
        { channel_id: 102, subject: "mary", content: "msg4" },
        { channel_id: 103, subject: "mary", content: "msg5" },
        { channel_id: 102, subject: "mary", content: "msg6" },
    ]

    result = List.walk(
        msgs,
        TopicHelper.new,
        |topic_helper, msg|
            (new_topic_helper, topic) = topic_helper |> TopicHelper.get_or_make_topic_for(msg.channel_id, msg.subject)
            dbg { msg, topic }
            new_topic_helper,
    )

    Stdout.line!("")

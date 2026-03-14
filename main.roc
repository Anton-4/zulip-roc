app [main!] { cli: platform "https://github.com/roc-lang/basic-cli/releases/download/0.20.0/X73hGh05nNTkDHU06FHC0YfFaQB1pimX7gncRcao5mU.tar.br" }

import cli.Stdout
import cli.Arg exposing [Arg]

Message : {
    channel_id : U64,
    subject : Str,
    content : Str,
}

ChannelId : U32
TopicId : U32

TopicMap : {
    seq : U32,
    key_to_channel : Dict Str U32,
}

get_topic_id : TopicMap, ChannelId, Str -> (TopicMap, TopicId)
get_topic_id = |topic_map, channel_id, topic_name|
    key_to_channel = topic_map.key_to_channel
    key = "${Num.to_str(channel_id)}-${topic_name}"
    when Dict.get(key_to_channel, key) is
        Ok(topic_id) ->
            (topic_map, topic_id)

        _ ->
            topic_id = topic_map.seq + 1
            new_topic_map = {
                seq: topic_id,
                key_to_channel: key_to_channel |> Dict.insert(key, topic_id),
            }
            (new_topic_map, topic_id)

main! : List Arg => Result {} _
main! = |_args|
    _ = Stdout.line!("\n\n--------------\n\n")

    msgs = [
        { channel_id: 1, subject: "fred", content: "msg1" },
        { channel_id: 1, subject: "fred", content: "msg2" },
        { channel_id: 1, subject: "mary", content: "msg3" },
        { channel_id: 2, subject: "mary", content: "msg4" },
        { channel_id: 3, subject: "mary", content: "msg5" },
        { channel_id: 2, subject: "mary", content: "msg6" },
    ]

    empty_topic_map = { seq: 0, key_to_channel: Dict.empty({}) }

    result = List.walk(
        msgs,
        empty_topic_map,
        |topic_map, msg|
            (new_topic_map, topic_id) = topic_map |> get_topic_id(msg.channel_id, msg.subject)
            new_msg = { channel_id: msg.channel_id, topic_id, content: msg.content }
            dbg { msg, topic_id, new_msg }
            new_topic_map,
    )

    dbg result

    Stdout.line!("")

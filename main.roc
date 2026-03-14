app [main!] { cli: platform "https://github.com/roc-lang/basic-cli/releases/download/0.20.0/X73hGh05nNTkDHU06FHC0YfFaQB1pimX7gncRcao5mU.tar.br" }

import cli.Stdout
import cli.Arg exposing [Arg]

ChannelId : U32
TopicId : U32

Topic: {
    topic_id: TopicId,
    channel_id: ChannelId,
    topic_name: Str,
}

TopicMap : {
    seq : U32,
    key_map : Dict Str TopicId,
    id_map: Dict TopicId Topic,
}

get_topic: TopicMap, TopicId -> Result Topic [KeyNotFound]
get_topic = |topic_map, topic_id|
    topic_map.id_map |> Dict.get(topic_id)

get_topic_id : TopicMap, ChannelId, Str -> (TopicMap, TopicId)
get_topic_id = |topic_map, channel_id, topic_name|
    key_map = topic_map.key_map
    key = "${Num.to_str(channel_id)}-${topic_name}"
    when Dict.get(key_map, key) is
        Ok(topic_id) ->
            (topic_map, topic_id)

        _ ->
            topic_id = topic_map.seq + 1
            topic = {topic_id, channel_id, topic_name}
            new_topic_map = {
                seq: topic_id,
                key_map: key_map |> Dict.insert(key, topic_id),
                id_map: topic_map.id_map |> Dict.insert(topic_id, topic),
            }
            (new_topic_map, topic_id)

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

    empty_topic_map = { seq: 0, key_map: Dict.empty({}), id_map: Dict.empty({}) }

    result = List.walk(
        msgs,
        empty_topic_map,
        |topic_map, msg|
            (new_topic_map, topic_id) = topic_map |> get_topic_id(msg.channel_id, msg.subject)
            new_msg = { channel_id: msg.channel_id, topic_id, content: msg.content }
            dbg { msg, topic_id, new_msg }
            new_topic_map,
    )

    dbg ("topic for id 1", result |> get_topic(1))

    Stdout.line!("")

module [TopicHelper, new, get_or_make_topic_for]

ChannelId : U32
TopicId : U32

Topic : {
    topic_id : TopicId,
    channel_id : ChannelId,
    topic_name : Str,
}

TopicHelper : {
    seq : U32,
    key_map : Dict Str Topic,
}

new : TopicHelper
new = { seq: 0, key_map: Dict.empty({}) }

get_or_make_topic_for : TopicHelper, ChannelId, Str -> (TopicHelper, Topic)
get_or_make_topic_for = |topic_helper, channel_id, topic_name|
    key = "${Num.to_str(channel_id)}-${topic_name}"
    when Dict.get(topic_helper.key_map, key) is
        Ok(topic) ->
            (topic_helper, topic)

        _ ->
            topic_id = topic_helper.seq + 1
            topic = { topic_id, channel_id, topic_name }
            new_topic_helper = {
                seq: topic_id,
                key_map: topic_helper.key_map |> Dict.insert(key, topic),
            }
            (new_topic_helper, topic)


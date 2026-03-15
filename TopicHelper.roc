module [empty_topic_helper, get_topic, get_topic_id, TopicHelper]

ChannelId : U32
TopicId : U32

Topic : {
    topic_id : TopicId,
    channel_id : ChannelId,
    topic_name : Str,
}

TopicHelper : {
    seq : U32,
    key_map : Dict Str TopicId,
    id_map : Dict TopicId Topic,
}

empty_topic_helper : TopicHelper
empty_topic_helper = { seq: 0, key_map: Dict.empty({}), id_map: Dict.empty({}) }

get_topic : TopicHelper, TopicId -> Result Topic [KeyNotFound]
get_topic = |topic_helper, topic_id|
    topic_helper.id_map |> Dict.get(topic_id)

get_topic_id : TopicHelper, ChannelId, Str -> (TopicHelper, TopicId)
get_topic_id = |topic_helper, channel_id, topic_name|
    key_map = topic_helper.key_map
    key = "${Num.to_str(channel_id)}-${topic_name}"
    when Dict.get(key_map, key) is
        Ok(topic_id) ->
            (topic_helper, topic_id)

        _ ->
            topic_id = topic_helper.seq + 1
            topic = { topic_id, channel_id, topic_name }
            new_topic_helper = {
                seq: topic_id,
                key_map: key_map |> Dict.insert(key, topic_id),
                id_map: topic_helper.id_map |> Dict.insert(topic_id, topic),
            }
            (new_topic_helper, topic_id)


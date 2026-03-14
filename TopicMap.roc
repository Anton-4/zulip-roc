module [empty_topic_map, get_topic, get_topic_id, TopicMap]

ChannelId : U32
TopicId : U32

Topic : {
    topic_id : TopicId,
    channel_id : ChannelId,
    topic_name : Str,
}

TopicMap : {
    seq : U32,
    key_map : Dict Str TopicId,
    id_map : Dict TopicId Topic,
}

empty_topic_map : TopicMap
empty_topic_map = { seq: 0, key_map: Dict.empty({}), id_map: Dict.empty({}) }

get_topic : TopicMap, TopicId -> Result Topic [KeyNotFound]
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
            topic = { topic_id, channel_id, topic_name }
            new_topic_map = {
                seq: topic_id,
                key_map: key_map |> Dict.insert(key, topic_id),
                id_map: topic_map.id_map |> Dict.insert(topic_id, topic),
            }
            (new_topic_map, topic_id)


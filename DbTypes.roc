module [Channel, Topic]

Channel : {
    channel_id: U32,
    name: Str,
}

Topic : {
    topic_id : U32,
    channel_id : U32,
    topic_name : Str,
}

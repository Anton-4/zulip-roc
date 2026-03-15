module [ID, Channel, Message, Topic]

ID : U32

Channel : {
    channel_id : ID,
    name : Str,
}

Message : {
    message_id : ID,
    sender_id : ID,
    channel_id : ID,
    topic_id : ID,
    content : Str,
}

Topic : {
    topic_id : ID,
    channel_id : ID,
    topic_name : Str,
}

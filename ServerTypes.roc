module [ServerMessage, ServerSubscription]

ID : U32

ServerSubscription : {
    stream_id : ID,
    name : Str,
}

ServerMessage : {
    content : Str,
    id : ID,
    sender_full_name : Str,
    sender_id : ID,
    subject : Str,
    stream_id : ID,
    type : Str, # should be "stream"
}

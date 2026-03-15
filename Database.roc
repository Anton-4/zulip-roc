module [Database, new, insert_channel, insert_message, set_topic]

import DbTypes exposing [ID, Channel, Message, Topic]

Database : {
    channel_map : Dict ID Channel,
    message_map : Dict ID Message,
    topic_map : Dict ID Topic,
}

new : Database
new = {
    channel_map: Dict.empty({}),
    message_map: Dict.empty({}),
    topic_map: Dict.empty({}),
}

insert_channel : Database, Channel -> Database
insert_channel = |database, channel|
    channel_id = channel.channel_id
    new_map = Dict.insert(database.channel_map, channel_id, channel)
    { database & channel_map: new_map }

insert_message : Database, Message -> Database
insert_message = |database, message|
    message_id = message.message_id
    new_map = Dict.insert(database.message_map, message_id, message)
    { database & message_map: new_map }

set_topic : Database, Topic -> Database
set_topic = |database, topic|
    topic_id = topic.topic_id
    new_map = Dict.insert(database.topic_map, topic_id, topic)
    { database & topic_map: new_map }

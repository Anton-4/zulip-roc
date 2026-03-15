module [Database, new, insert_channel]

import DbTypes exposing [Channel, Topic]

Database : {
    channel_map : Dict U32 Channel,
    topic_map : Dict U32 Topic,
}

new : Database
new = {
    channel_map: Dict.empty({}),
    topic_map: Dict.empty({}),
}

insert_channel : Database, Channel -> Database
insert_channel = |database, channel|
    channel_id = channel.channel_id
    new_map = Dict.insert(database.channel_map, channel_id, channel)
    { database & channel_map: new_map }

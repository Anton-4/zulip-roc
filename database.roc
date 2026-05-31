import DbTypes

Database := {
	channel_map : Dict(U32, DbTypes.Channel),
	message_map : Dict(U32, DbTypes.Message),
	topic_map : Dict(U32, DbTypes.Topic),
	user_map : Dict(U32, DbTypes.User),
}.{
	new : () -> Database
	new = || {
		channel_map: Dict.empty(),
		message_map: Dict.empty(),
		topic_map: Dict.empty(),
		user_map: Dict.empty(),
	}

	insert_channel : Database, DbTypes.Channel -> Database
	insert_channel = |database, channel|
		{ ..database, channel_map: database.channel_map.insert(channel.channel_id, channel) }

	insert_message : Database, DbTypes.Message -> Database
	insert_message = |database, message|
		{ ..database, message_map: database.message_map.insert(message.message_id, message) }

	set_topic : Database, DbTypes.Topic -> Database
	set_topic = |database, topic|
		{ ..database, topic_map: database.topic_map.insert(topic.topic_id, topic) }
}

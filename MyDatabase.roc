import DbTypes

MyDatabase := {
	channel_map : Dict(U32, DbTypes.Channel),
	message_map : Dict(U32, DbTypes.Message),
	topic_map : Dict(U32, DbTypes.Topic),
	user_map : Dict(U32, DbTypes.User),
}.{
	new : () -> MyDatabase
	new = || {
		channel_map: Dict.empty(),
		message_map: Dict.empty(),
		topic_map: Dict.empty(),
		user_map: Dict.empty(),
	}

	insert_channel : MyDatabase, DbTypes.Channel -> MyDatabase
	insert_channel = |MyDatabase, channel|
		{ ..MyDatabase, channel_map: MyDatabase.channel_map.insert(channel.channel_id, channel) }

	insert_message : MyDatabase, DbTypes.Message -> MyDatabase
	insert_message = |MyDatabase, message|
		{ ..MyDatabase, message_map: MyDatabase.message_map.insert(message.message_id, message) }

	set_topic : MyDatabase, DbTypes.Topic -> MyDatabase
	set_topic = |MyDatabase, topic|
		{ ..MyDatabase, topic_map: MyDatabase.topic_map.insert(topic.topic_id, topic) }
}

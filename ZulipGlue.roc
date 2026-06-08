import MyDatabase
import ServerTypes
import TopicHelper

ZulipGlue :: [].{
	process_server_subscription : MyDatabase.MyDatabase, ServerTypes.ServerSubscription -> MyDatabase.MyDatabase
	process_server_subscription = |db, subscription| {
		channel = {
			channel_id: subscription.stream_id,
			name: subscription.name,
		}
		db.insert_channel(channel)
	}

	process_server_message : MyDatabase.MyDatabase, ServerTypes.ServerMessage, TopicHelper.TopicHelper -> MyDatabase.MyDatabase
	process_server_message = |db, server_message, topic_helper| {
		message_id = server_message.id
		channel_id = server_message.stream_id
		topic_name = server_message.subject

		# TODO: call fix_content
		content = server_message.content

		sender_id = server_message.sender_id

		(_, topic) = topic_helper.get_or_make_topic_for(channel_id, topic_name)
		db_with_topic = db.set_topic(topic)
		topic_id = topic.topic_id

		message = {
			content,
			message_id,
			sender_id,
			channel_id,
			topic_id,
		}

		db_with_topic.insert_message(message)
	}
}

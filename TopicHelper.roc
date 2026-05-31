import DbTypes

TopicHelper := {
	seq : U32,
	key_map : Dict(Str, DbTypes.Topic),
}.{
	new : () -> TopicHelper
	new = || { seq: 0, key_map: Dict.empty() }

	get_or_make_topic_for : TopicHelper, U32, Str -> (TopicHelper, DbTypes.Topic)
	get_or_make_topic_for = |topic_helper, channel_id, topic_name| {
		key = "${channel_id.to_str()}-${topic_name}"
		match topic_helper.key_map.get(key) {
			Ok(topic) =>
				(topic_helper, topic)

			_ => {
				topic_id = topic_helper.seq + 1
				topic = { topic_id, channel_id, topic_name }
				new_topic_helper = {
					seq: topic_id,
					key_map: topic_helper.key_map.insert(key, topic),
				}
				(new_topic_helper, topic)
			}
		}
	}
}

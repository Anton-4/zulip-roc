DbTypes :: [].{
	# Note: the old code used `ID : U32` as a type alias for these id fields.
	# The new compiler currently mishandles an alias-of-a-builtin used both as a
	# Dict key and inside a Dict-value record (layout panic / anonymous recursion),
	# so we inline `U32` here. The meaning is identical to the old `ID`.

	Channel : {
		channel_id : U32,
		name : Str,
	}

	Message : {
		message_id : U32,
		sender_id : U32,
		channel_id : U32,
		topic_id : U32,
		content : Str,
	}

	Topic : {
		topic_id : U32,
		channel_id : U32,
		topic_name : Str,
	}

	User : {
		user_id : U32,
		full_name : Str,
	}
}

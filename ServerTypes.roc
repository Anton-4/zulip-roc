ServerTypes :: [].{
	ServerSubscription : {
		stream_id : U32,
		name : Str,
	}

	ServerMessage : {
		content : Str,
		id : U32,
		sender_full_name : Str,
		sender_id : U32,
		subject : Str,
		stream_id : U32,
		type : Str, # should be "stream"
	}
}

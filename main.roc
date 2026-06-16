app [main!] { pf: platform "https://github.com/lukewilliamboswell/roc-platform-template-zig/releases/download/0.8/8qf28cxTaxwA16Xe3VBR7YSP2KLVUqDHiPpFYgyikEa1.tar.zst" }

import pf.Stdout

import MyDatabase
import TopicHelper
import ZulipGlue

print! = |something| {
	Stdout.line!(Str.inspect(something))
}

main! = |_args| {
	# Note: in the old code these fixtures were top-level definitions. The new
	# compiler currently crashes when it compile-time finalizes a top-level
	# constant whose value comes from a record update (`{ ..db, ... }`), so we
	# build them as locals inside `main!` (evaluated at runtime) instead.

	test_insert_channel = {
		channel = { channel_id: 101, name: "Engineering" }
		MyDatabase.new().insert_channel(channel)
	}

	test_insert_message = {
		message = {
			channel_id: 99,
			content: "some content",
			message_id: 1001,
			sender_id: 99,
			topic_id: 99,
		}
		MyDatabase.new().insert_message(message)
	}

	test_process_server_subscription = {
		subscription = { stream_id: 201, name: "Design" }
		ZulipGlue.process_server_subscription(MyDatabase.new(), subscription)
	}

	test_process_server_message = {
		message = {
			content: "some content",
			id: 1001,
			sender_full_name: "Foo Barson",
			sender_id: 1,
			subject: "some topic",
			stream_id: 101,
			type: "stream",
		}
		ZulipGlue.process_server_message(MyDatabase.new(), message, TopicHelper.new())
	}

	print!(test_insert_channel)
	print!(test_insert_message)
	print!(test_process_server_subscription)
	print!(test_process_server_message)

	Ok({})
}

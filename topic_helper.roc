app [main!] { pf: platform "https://github.com/lukewilliamboswell/roc-platform-template-zig/releases/download/0.7/DuRUyJh31Gt41YArMcVcvybLa2bCWboccWQ7Zq1KZPZ6.tar.zst" }

import pf.Stdout

import TopicHelper

print! = |something| {
	Stdout.line!(Str.inspect(something))
}

main! = |_args| {
	msgs = [
		{ channel_id: 101, subject: "fred", content: "msg1" },
		{ channel_id: 101, subject: "fred", content: "msg2" },
		{ channel_id: 101, subject: "mary", content: "msg3" },
		{ channel_id: 102, subject: "mary", content: "msg4" },
		{ channel_id: 103, subject: "mary", content: "msg5" },
		{ channel_id: 102, subject: "mary", content: "msg6" },
	]

	final_topic_helper = msgs.fold(
		TopicHelper.new(),
		|topic_helper, msg| {
			(new_topic_helper, topic) = topic_helper.get_or_make_topic_for(msg.channel_id, msg.subject)
			dbg { msg, topic }
			new_topic_helper
		},
	)

	print!(final_topic_helper)

	Ok({})
}

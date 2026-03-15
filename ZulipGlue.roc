module [process_server_subscription]

import Database
import ServerTypes exposing [ServerMessage, ServerSubscription]

process_server_subscription : Database.Database, ServerSubscription -> Database.Database
process_server_subscription = |db, subscription|
    channel = {
        channel_id: subscription.stream_id,
        name: subscription.name,
    }
    db |> Database.insert_channel(channel)

process_server_message: Database.Database, ServerMessage -> Database.Database
process_server_message = |db, server_message|
    message_id = server_message.id
    channel_id = server_message.stream_id
    topic_name = server_message.subject

    # TODO: call fix_content
    content = server_message.content

    sender_id = server_message.sender_id

    topic_id = 42
    # topic = TOPIC_HELPER.get_or_make_topic_for(channel_id, topic_name);
    # database.set_topic(topic);
    # topic_id = topic.topic_id;

    message = {
        content,
        message_id,
        sender_id,
        channel_id,
        topic_id,
    }

    db |> Database.insert_message(message)

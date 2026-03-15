module [process_server_subscription]

import Database
import ServerTypes exposing [ServerSubscription]

process_server_subscription : Database.Database, ServerSubscription -> Database.Database
process_server_subscription = |db, subscription|
    channel = {
        channel_id: subscription.stream_id,
        name: subscription.name,
    }
    db |> Database.insert_channel(channel)

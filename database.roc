app [main!] { cli: platform "https://github.com/roc-lang/basic-cli/releases/download/0.20.0/X73hGh05nNTkDHU06FHC0YfFaQB1pimX7gncRcao5mU.tar.br" }

import cli.Stdout
import cli.Arg exposing [Arg]

import Database
# import ZulipGlue

main! : List Arg => Result {} _
main! = |_args|
    channel = { channel_id: 101, name: "Engineering" }
    db = Database.new
    dbg db
    new_db = db |> Database.insert_channel(channel)
    dbg new_db

    # new_db = ZulipGlue.process_server_subscription(database, subscription)

    Stdout.line!("")

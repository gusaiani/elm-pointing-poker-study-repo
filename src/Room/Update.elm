module Room.Update exposing (update)

import Room.Commands exposing (fbEditQuestion, fbVote)
import Room.Messages exposing (Msg(..))
import Room.Models exposing (Room)


update : Msg -> Room -> String -> ( Room, Cmd Msg )
update msg room userName =
    case msg of
        RoomUpdate newRoom ->
            ( newRoom, Cmd.none )

        EditQuestion newQuestion ->
            ( { room | question = newQuestion }, fbEditQuestion newQuestion )

        Vote vote ->
            ( room
            , fbVote
                ({ userName = userName
                 , vote = vote
                 }
                )
            )

port module Room.Commands exposing (..)

import Dict
import Json.Decode as Decode
import Json.Encode as Encode
import Task
import Room.Models exposing (Room)
import Room.Messages exposing (..)


port fbVote : { userName : String, vote : Int } -> Cmd msg


port fbEditQuestion : String -> Cmd msg


receive : Encode.Value -> Cmd Msg
receive json =
    let
        decodedItemsResult =
            Decode.decodeValue roomDecoder json

        room =
            case decodedItemsResult of
                Ok decodedItems ->
                    decodedItems

                Err err ->
                    let
                        _ =
                            Debug.log "error" err
                    in
                        Room "" Dict.empty
    in
        Task.perform RoomUpdate (Task.succeed room)


roomDecoder : Decode.Decoder Room
roomDecoder =
    Decode.map2 Room
        (Decode.oneOf
            [ Decode.field "question" Decode.string
            , Decode.succeed ""
            ]
        )
        (Decode.field "users" (Decode.dict Decode.int))

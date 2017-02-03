module Room.Messages exposing (..)

import Room.Models exposing (Room)


type Msg
    = RoomUpdate Room
    | EditQuestion String
    | Vote Int

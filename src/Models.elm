module Models exposing (..)

import Room.Models exposing (Room, initRoom)
import Login.Models exposing (Login, initLogin)


type alias Model =
    { room : Room
    , login : Login
    }


initModel : Model
initModel =
    Model initRoom initLogin

module Room.Models exposing (..)

import Dict


type alias Room =
    { question : String
    , items : Dict.Dict String Int
    }


initRoom : Room
initRoom =
    Room "" Dict.empty

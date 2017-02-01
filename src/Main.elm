port module Main exposing (..)

import Html
import Messages exposing (Msg(..))
import Models exposing (Model, initModel)
import View exposing (view)
import Update exposing (update)
import Json.Encode as Encode
import Platform.Sub


type alias Flags =
    { room : String }


init : Flags -> ( Model, Cmd Msg )
init flags =
    let
        login =
            initModel.login

        newLogin =
            { login | roomName = flags.room }
    in
        ( { initModel | login = newLogin }, Cmd.none )


port receiveRoomData : (Encode.Value -> msg) -> Sub msg


port receiveIsNameAvailable : (Encode.Value -> msg) -> Sub msg


main =
    Html.programWithFlags
        { init = init
        , view = view
        , update = update
        , subscriptions =
            (\model ->
                Platform.Sub.batch
                    [ receiveRoomData ReceiveFBRoomData
                    , receiveIsNameAvailable ReceiveFBIsNameAvailable
                    ]
            )
        }

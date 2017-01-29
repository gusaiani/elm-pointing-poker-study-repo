port module Main exposing (..)

import Html
import Messages exposing (Msg(..))
import Models exposing (Model, initModel)
import View exposing (view)
import Update exposing (update)
import Json.Encode exposing Encode
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

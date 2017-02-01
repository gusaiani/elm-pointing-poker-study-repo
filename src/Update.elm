module Update exposing (..)

import Json.Decode as Decode
import Task
import Messages exposing (Msg(..))
import Models exposing (Model)
import Login.Messages
import Login.Update
import Room.Commands
import Room.Update


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        RoomMsg subMsg ->
            let
                ( newRoom, cmd ) =
                    Room.Update.update subMsg model.room model.login.userName
            in
                ( { model | room = newRoom }, Cmd.map RoomMsg cmd )

        LoginMsg subMsg ->
            let
                ( newLogin, cmd ) =
                    Login.Update.update subMsg model.login
            in
                ( { model | login = newLogin }, Cmd.map LoginMsg cmd )

        ReceiveFBRoomData json ->
            ( model, Cmd.map RoomMsg (Room.Commands.receive json) )

        ReceiveFBIsNameAvailable json ->
            let
                decodedResult =
                    Decode.decodeValue Decode.bool json

                isNameAvailable =
                    case decodedResult of
                        Ok decoded ->
                            decoded

                        Err err ->
                            False
            in
                ( model
                , Cmd.map LoginMsg
                    (Task.perform Login.Messages.IsNameAvailable
                        (Task.succeed isNameAvailable)
                    )
                )

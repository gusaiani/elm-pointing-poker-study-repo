module Login.Update exposing (update)

import Login.Commands exposing (checkIsNameAvailable, fbJoinRoom, validateLogin)
import Login.Messages exposing (Msg(..))
import Login.Models exposing (Login)


update : Msg -> Login -> ( Login, Cmd Msg )
update msg login =
    case msg of
        LoginUpdate newLogin ->
            ( newLogin, Cmd.none )

        IsNameAvailable isNameAvailable ->
            let
                errors =
                    login.errors

                ( cmd, newErrors ) =
                    case isNameAvailable of
                        True ->
                            ( fbJoinRoom login, errors )

                        False ->
                            ( Cmd.none
                            , { errors | userName = "This name is already in use. Try anouther one." }
                            )
            in
                ( { login
                    | isValid = isNameAvailable
                    , errors = newErrors
                  }
                , cmd
                )

        EditRoomName name ->
            ( { login | roomName = name }, Cmd.none )

        EditUserName name ->
            ( { login | userName = name }, Cmd.none )

        SubmitForm ->
            let
                ( isValid, newLogin ) =
                    validateLogin login

                cmd =
                    case isValid of
                        True ->
                            checkIsNameAvailable login

                        False ->
                            Cmd.none
            in
                ( newLogin, cmd )

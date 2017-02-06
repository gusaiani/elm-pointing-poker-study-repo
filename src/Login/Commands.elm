port module Login.Commands exposing (..)

import Regex
import Login.Models exposing (Login)


port fbJoinRoom : Login -> Cmd msg


port checkIsNameAvailable : Login -> Cmd msg


validateLogin : Login -> ( Bool, Login )
validateLogin login =
    let
        errors =
            login.errors

        newErrors =
            { errors
                | userName = validateName login.userName
                , roomName = validateName login.roomName
            }

        isValid =
            String.isEmpty newErrors.userName && String.isEmpty newErrors.roomName
    in
        ( isValid, { login | errors = newErrors } )


validateName : String -> String
validateName name =
    if String.isEmpty name then
        "Can't be empty"
    else if (String.length name) > 20 then
        "Name is too long"
    else if Regex.contains (Regex.regex "^[a-zA-Z0-9]+$") name == False then
        "Name can include only this characters: 'a-Z' and '0-9'"
    else
        ""

module Login.Messages exposing (Msg(..))

import Login.Models exposing (Login)


type Msg
    = LoginUpdate Login
    | EditRoomName String
    | EditUserName String
    | IsNameAvailable Bool
    | SubmitForm

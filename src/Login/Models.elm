module Login.Models exposing (..)


type alias Login =
    { roomName : String
    , userName : String
    , errors : LoginErrors
    , isValid : Bool
    }


type alias LoginErrors =
    { roomName : String
    , userName : String
    }


initLogin : Login
initLogin =
    Login "" "" initLoginErrors False


initLoginErrors : LoginErrors
initLoginErrors =
    LoginErrors "" ""

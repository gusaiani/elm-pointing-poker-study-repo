module Login.View exposing (..)

import Html exposing (..)
import Html.Events exposing (onInput, onClick)
import Html.Attributes exposing (class, placeholder, value)
import Login.Messages exposing (..)
import Login.Models exposing (Login)


view : Login -> Html Msg
view login =
    div [ class "LoginPage column is-half is-offset-one-quarter" ]
        [ h4 [] [ text "Welcome!" ]
        , h6 []
            [ text "Please select a room you want to "
            , strong [] [ text "join" ]
            , text " or "
            , strong [] [ text "create" ]
            , text "."
            ]
        , p [ class "control has-icon" ]
            [ input
                [ class "input"
                , placeholder "Room name"
                , onInput EditRoomName
                , value login.roomName
                ]
                []
            , i [ class "fa fa-home" ] []
            , span [ class "help is-danger" ] [ text login.errors.roomName ]
            ]
        , p [ class "control has-icon" ]
            [ input
                [ class "input"
                , placeholder "User name"
                , onInput EditUserName
                , value login.userName
                ]
                []
            , i [ class "fa fa-user" ] []
            , span [ class "help is-danger" ] [ text login.errors.userName ]
            ]
        , p [ class "control" ]
            [ button
                [ class "button is-primary"
                , onClick SubmitForm
                ]
                [ text "Submit" ]
            ]
        ]

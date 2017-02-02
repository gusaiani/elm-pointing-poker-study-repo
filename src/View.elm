module View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, placeholder, value)
import Messages exposing (Msg(..))
import Models exposing (Model)
import Room.View
import Login.View


view : Model -> Html Msg
view model =
    let
        content =
            case model.login.isValid of
                True ->
                    Html.map RoomMsg (Room.View.view model.room)

                False ->
                    Html.map LoginMsg (Login.View.view model.login)
    in
        div [ class "content" ]
            [ renderHeader model
            , div [ class "PageContainer columns is-mobile" ] [ content ]
            ]


renderHeader : Model -> Html Msg
renderHeader model =
    let
        headerBody =
            case model.login.isValid of
                True ->
                    div [ class "hero-body" ]
                        [ div [ class "container" ]
                            [ renderHeaderBody model ]
                        ]

                False ->
                    span [] []
    in
        section [ class "hero is-primary" ]
            [ div [ class "hero-head" ]
                [ div [ class "container" ]
                    [ renderHeaderHead model ]
                ]
            , headerBody
            ]


renderHeaderHead : Model -> Html Msg
renderHeaderHead model =
    nav [ class "nav" ]
        [ div [ class "nav-left" ]
            [ b [ class "nav-item is-brand" ]
                [ text "Pointing Poker" ]
            ]
        , div [ class "nav-right nav-menu" ]
            [ span [ class "nav-item" ]
                [ a
                    [ class "button is-primary is-inverted"
                    , Html.Attributes.href "https://github.com/liubko/elm-pointing-poker"
                    ]
                    [ span [ class "icon" ]
                        [ i [ class "fa fa-github" ]
                            []
                        ]
                    , span []
                        [ text "Source" ]
                    ]
                ]
            ]
        ]


renderHeaderBody : Model -> Html Msg
renderHeaderBody model =
    div [ class "columns is-vcentered" ]
        [ div [ class "column" ]
            [ h4 [ class "title" ]
                [ text ("User: " ++ model.login.userName) ]
            , h6 [ class "subtitle" ]
                [ text ("https://poker-94672.firebaseapp.com/#" ++ model.login.roomName) ]
            ]
        ]

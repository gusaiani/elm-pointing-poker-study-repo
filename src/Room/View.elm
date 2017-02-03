module Room.View exposing (..)

import Dict
import Html exposing (..)
import Html.Attributes exposing (class, placeholder, value)
import Html.Events exposing (onClick, onInput)
import Html.Keyed as Keyed
import Room.Messages exposing (..)
import Room.Models exposing (Room)


view : Room -> Html Msg
view room =
    div [ class "columns column is-10 is-offset-1" ]
        [ div [ class "column" ]
            [ renderQuestionSection room.question
            , renderVoteSection
            ]
        , div [ class "column is-5" ]
            [ renderUsersSection room.items
            ]
        ]


renderQuestionSection : String -> Html Msg
renderQuestionSection question =
    div [ class "control is-grouped" ]
        [ p [ class "control is-expanded" ]
            [ label [ class "label" ] [ text "Question" ]
            , input
                [ class "input"
                , placeholder "Enter task description"
                , onInput EditQuestion
                , value question
                ]
                []
            ]
        ]


renderButton : ( Int, String ) -> ( String, Html Msg )
renderButton ( vote, label ) =
    ( label
    , p [ class "control" ]
        [ a
            [ class "button"
            , onClick (Vote vote)
            ]
            [ text label ]
        ]
    )


renderVoteSection : Html Msg
renderVoteSection =
    let
        items =
            [ ( 1, "1 point" )
            , ( 2, "2 points" )
            , ( 3, "3 points" )
            , ( 4, "4 points" )
            , ( 5, "5 points" )
            ]

        buttons =
            List.map renderButton items
    in
        div []
            [ label [ class "label" ] [ text "Your Vote" ]
            , Keyed.node "div" [ class "control is-grouped" ] (buttons)
            ]


renderUsersSection : Dict.Dict String Int -> Html Msg
renderUsersSection items =
    let
        userList =
            items
                |> Dict.toList
                |> List.map renderUser

        totalVotes =
            items
                |> Dict.toList
                |> List.map (\( name, vote ) -> vote)
                |> List.sum

        numOfVotes =
            items
                |> Dict.toList
                |> List.filter (\( name, vote ) -> vote >= 0)
                |> List.length

        average =
            toFloat totalVotes / toFloat numOfVotes
    in
        div []
            [ label [ class "label" ] [ text ("Average Score: " ++ (toString average)) ]
            , table [ class "table" ]
                [ thead []
                    [ tr []
                        [ th []
                            [ text "Name" ]
                        , th []
                            [ text "Points" ]
                        ]
                    ]
                , Keyed.node "tbody" [] (userList)
                ]
            ]


renderUser : ( String, Int ) -> ( String, Html Msg )
renderUser ( name, vote ) =
    ( (toString name)
    , tr []
        [ td []
            [ text name ]
        , td []
            [ Html.b [] [ text (toString vote) ] ]
        ]
    )

module View exposing (view)

import Html exposing (Html, button, div, input, text)
import Html.Attributes exposing (placeholder, style, type_)
import Html.Events exposing (onClick, onInput)
import Http
import Model exposing (..)
import User
import Model


{- Main view function -}


view : Model -> Html Msg
view model =
    div mainStyle
        [ div innerStyle
            [ label "AUTH App"
            , messageDisplay model
            , sampleInput model
            , sampleButton model
            , authorizationButton model
            , tokenDisplay model
            ]
        ]


showIf condition element =
    if condition then
        element
    else
        text ""



{- Outputs -}


label str =
    div [ style "margin-bottom" "10px", style "font-weight" "bold" ]
        [ (text str) ]


messageDisplay model =
    div [ style "margin-bottom" "10px" ]
        [ (text model.message) ]


tokenDisplay model =
  let 
    reply = case model.userModel.maybeUser of 
      Nothing -> "No token"
      Just user -> user.firstname ++ ", you are authorized."
    in 
    div [ style "margin-top" "10px" ]
        [ text reply ]


{- Inputs -}


sampleInput model =
    div [ style "margin-bottom" "10px" ]
        [ input [ type_ "text", placeholder "Enter text here", onInput Input ] [] ]



{- Controls -}


sampleButton model =
    div [ style "margin-bottom" "0px" ]
        [ button [ onClick ReverseText ] [ text "Reverse" ] ]

authorizationButton model =
    div [ style "margin-bottom" "0px" ]
        [ button [ onClick rq] [ text "Authorization" ] ]

rq = UserMsg <| User.RequestAuthorization "jxxcarlson@gmail.com" "lobo4795"

{- Style -}


mainStyle =
    [ style "margin" "15px"
    , style "margin-top" "20px"
    , style "background-color" "#eee"
    , style "width" "240px"
    ]


innerStyle =
    [ style "padding" "15px" ]

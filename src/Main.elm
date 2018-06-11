port module WeatherApp exposing (main)

{- This app retrieves and displays weather data from openweathermap.org. -}

import Browser
import Html
import Model exposing(..)
import View exposing (view)
import User exposing(UserMsg)


main =
    Browser.embed
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


type alias Flags =
    {}


init : Flags -> ( Model, Cmd Msg )
init flags =
    ( Model.init
    , Cmd.none
    )


subscriptions model =
    Sub.none


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        Input str ->
            ( { model | message = str }, Cmd.none )

        ReverseText ->
            ( { model | message = model.message |> String.reverse |> String.toLower }, Cmd.none )
 
        UserMsg submessage ->
            let
                userModel = model.userModel
                (nextUserModel, cmd) = User.update  userModel submessage
            in 
                ({model | userModel = nextUserModel}, Cmd.map UserMsg cmd)

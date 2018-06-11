module Model exposing(..)

import User exposing(UserMsg)

type alias Model = 
    { 
       userModel : User.Model
       , message : String
    }

init : Model 
init = 
    {
        userModel = User.init
        , message = "Starting up"
    }


type Msg
    = NoOp
    | Input String
    | ReverseText
    | UserMsg UserMsg

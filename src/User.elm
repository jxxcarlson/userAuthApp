module User exposing(..)

import Json.Decode as D
import Json.Encode as E
import Http as H

type alias Model = 
 { maybeUser : Maybe User
 , errorMessage : String}

init : Model 
init =
  {  
   maybeUser = Nothing,
   errorMessage = ""
   }

type alias User =
  {  username: String
   , firstname: String
   , email: String
   , token : String
  }

type UserMsg =
   ReceiveAuthorization (Result H.Error User)
  | RequestAuthorization String String 


update : Model -> UserMsg -> (Model, Cmd UserMsg)
update model msg = 
  case msg of 
    ReceiveAuthorization (Ok user) ->
      ({model | maybeUser = Just user}, Cmd.none)
    ReceiveAuthorization (Err _) ->
      ({model | errorMessage = "Authorization error"}, Cmd.none)
    RequestAuthorization email password -> (model, getAuthorization email password)


userDecoder : D.Decoder User
userDecoder =
   D.map4 User 
     (D.field "username" D.string)
     (D.field "firstname" D.string)
     (D.field "email" D.string)
     (D.field "token" D.string)

authorizationEncoder : String -> String -> E.Value
authorizationEncoder email password =
   E.object
    [ ("email", E.string email)
    , ("password", E.string password)
    ]

authenticationRequest : String -> String -> H.Request User
authenticationRequest email password = 
  H.request
    { method = "Post"
    , headers = []
    , url = "http://localhost:4000/api/users/authenticate"
    , body = H.jsonBody (authorizationEncoder email password)
    , expect = H.expectJson userDecoder
    , timeout = Just 1000
    , withCredentials = False
    }

getAuthorization : String -> String -> Cmd UserMsg 
getAuthorization email password =
  let 
    _ = Debug.log "getAuthorization email" email 
  in 
    H.send ReceiveAuthorization <| authenticationRequest email password
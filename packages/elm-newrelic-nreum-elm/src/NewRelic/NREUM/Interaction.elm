module NewRelic.NREUM.Interaction exposing
    ( Interaction
    , init
    , withActionText
    , encode
    , withSetAttribute
    )

{-| Returns a new API object that is bound to the current SPA interaction.
This method returns an API object that is bound to a specific BrowserInteraction event.
Each time this method is called for the same BrowserInteraction, a new object is created, but it still references the same interaction.


## Configuration

@docs Interaction


## Configuration Methods

@docs init


## Overlay Configuration

@docs withActionText, withSetAttributes


## Encoding

@docs encode

-}

import Json.Encode as JE


type Interaction
    = Interaction InteractionConfiguration


type alias InteractionConfiguration =
    { name : String
    , actionText : Maybe String
    , attributes : List InteractionAttribute
    }


type alias InteractionAttribute =
    { key : String
    , value : String
    }


{-| Build Nreum NoticeError with specific action name
-}
init : String -> Interaction
init name =
    Interaction (InteractionConfiguration name Nothing [])


{-| Add custom attribute to Nreum Interaction
-}
withSetAttribute : String -> String -> Interaction -> Interaction
withSetAttribute key value (Interaction interaction) =
    let
        interactionAttr : InteractionAttribute
        interactionAttr =
            InteractionAttribute key value
    in
    Interaction { interaction | attributes = interactionAttr :: interaction.attributes }


{-| Add sets the text value of the HTML element that was clicked to Nreum Interaction
-}
withActionText : String -> Interaction -> Interaction
withActionText actionText (Interaction interaction) =
    Interaction { interaction | actionText = Just actionText }


{-| Convert Nreum NoticeError to JSON
-}
encode : Interaction -> JE.Value
encode (Interaction config) =
    JE.object
        ([ ( "name", JE.string config.name )
         , ( "attributes", config.attributes |> JE.list encodeAttribute )
         ]
            ++ appendMaybe config.actionText encodeActionText
        )


{-| Convert custom attributes of Nreum Interaction to JSON
-}
encodeAttribute : InteractionAttribute -> JE.Value
encodeAttribute interactionAttribute =
    JE.object
        [ ( "key", JE.string interactionAttribute.key )
        , ( "value", JE.string interactionAttribute.value )
        ]


encodeActionText : String -> List ( String, JE.Value )
encodeActionText actionText =
    [ ( "action", JE.string actionText ) ]


appendMaybe : Maybe a -> (a -> List b) -> List b
appendMaybe maybe mapper =
    maybe
        |> Maybe.map mapper
        |> Maybe.withDefault []

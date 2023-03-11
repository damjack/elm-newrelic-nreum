module NewRelic.NREUM.Interaction exposing
    ( Interaction
    , init
    , addMessage, addAdditionalData
    , encode
    )

{-| Returns a new API object that is bound to the current SPA interaction.
This method returns an API object that is bound to a specific BrowserInteraction event.
Each time this method is called for the same BrowserInteraction, a new object is created, but it still references the same interaction.


## Configuration

@docs Interaction


## Configuration Methods

@docs init


## Overlay Configuration

@docs addMessage, addAdditionalData


## Encoding

@docs encode

-}

import Json.Encode as JE
import NewRelic.AdditionalData as AdditionalData


{-| Interaction type
-}
type Interaction
    = Interaction InteractionConfiguration


type alias InteractionConfiguration =
    { interactionName : String
    , interactionMessage : Maybe String
    , additionalData : List AdditionalData.AdditionalData
    }


{-| Build Nreum NoticeError with specific action name
-}
init : String -> Interaction
init interactionName =
    Interaction (InteractionConfiguration interactionName Nothing [])


{-| Add custom attribute to Nreum Interaction
-}
addAdditionalData : AdditionalData.AdditionalData -> Interaction -> Interaction
addAdditionalData additionalData (Interaction config) =
    Interaction { config | additionalData = additionalData :: config.additionalData }


{-| Add sets the text value of the HTML element that was clicked to Nreum Interaction
-}
addMessage : String -> Interaction -> Interaction
addMessage interactionMessage (Interaction config) =
    Interaction { config | interactionMessage = Just interactionMessage }


{-| Convert Nreum NoticeError to JSON
-}
encode : Interaction -> JE.Value
encode (Interaction config) =
    JE.object
        ([ ( "interactionName", JE.string config.interactionName )
         , ( "additionalData", encodeAdditionalData config )
         , ( "type_", JE.string "interaction" )
         ]
            ++ appendMaybe config.interactionMessage encodeMessage
        )


{-| Convert custom attributes of Nreum Interaction to JSON
-}
encodeAdditionalData : InteractionConfiguration -> JE.Value
encodeAdditionalData { additionalData } =
    JE.object
        (additionalData |> List.map (\data -> AdditionalData.encode data))


encodeMessage : String -> List ( String, JE.Value )
encodeMessage interactionMessage =
    [ ( "interactionMessage", JE.string interactionMessage ) ]


appendMaybe : Maybe a -> (a -> List b) -> List b
appendMaybe maybe mapper =
    maybe
        |> Maybe.map mapper
        |> Maybe.withDefault []

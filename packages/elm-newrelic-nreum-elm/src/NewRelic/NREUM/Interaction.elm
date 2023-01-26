module NewRelic.NREUM.Interaction exposing
    ( Interaction
    , init
    , addActionText
    , encode
    , addSetAttribute
    )

{-| Returns a new API object that is bound to the current SPA interaction.
This method returns an API object that is bound to a specific BrowserInteraction event.
Each time this method is called for the same BrowserInteraction, a new object is created, but it still references the same interaction.


## Configuration

@docs Interaction


## Configuration Methods

@docs init


## Overlay Configuration

@docs addActionText, addSetAttributes


## Encoding

@docs encode

-}

import Json.Encode as JE
import NewRelic.AdditionalData as AdditionalData


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
addAdditionalData additionalData (Interaction interaction) =
    Interaction { interaction | additionalData = additionalData :: interaction.additionalData }


{-| Add sets the text value of the HTML element that was clicked to Nreum Interaction
-}
addMessage : String -> Interaction -> Interaction
addMessage interactionMessage (Interaction interaction) =
    Interaction { interaction | interactionMessage = Just interactionMessage }


{-| Convert Nreum NoticeError to JSON
-}
encode : Interaction -> JE.Value
encode (Interaction interaction) =
    JE.object
        ([ ( "interactionName", JE.string interaction.interactionName )
         , ( "additionalData", encodeAdditionalData interaction )
         , ( "type_", JE.string "interaction" )
         ]
            ++ appendMaybe interaction.interactionMessage encodeMessage
        )


{-| Convert custom attributes of Nreum Interaction to JSON
-}
encodeAdditionalData : AddPageActionConfiguration -> JE.Value
encodeAdditionalData { additionalDataList } =
    JE.object
        (additionalDataList |> List.map (\data -> AdditionalData.encode data))


encodeMessage : String -> List ( String, JE.Value )
encodeMessage interactionMessage =
    [ ( "interactionMessage", JE.string interactionMessage ) ]


appendMaybe : Maybe a -> (a -> List b) -> List b
appendMaybe maybe mapper =
    maybe
        |> Maybe.map mapper
        |> Maybe.withDefault []

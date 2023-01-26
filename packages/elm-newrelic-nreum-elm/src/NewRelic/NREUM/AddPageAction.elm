module NewRelic.NREUM.AddPageAction exposing
    ( AddPageAction
    , init
    , addAdditionalData
    , encode
    )

{-| Reports a browser AddPageAction event to New Relic One along with a name and optional attributes.
This API call sends a browser AddPageAction event with your user-defined name and optional attributes to dashboards, along with several default attributes.
This is useful to track any event that is not already tracked automatically by the browser agent, such as clicking a Subscribe button or accessing a tutorial.


## Configuration

@docs AddPageAction


## Configuration Methods

@docs init


## Overlay Configuration

@docs addAdditionalData


## Encoding

@docs encode

-}

import Json.Encode as JE
import NewRelic.AdditionalData as AdditionalData


type AddPageAction
    = AddPageAction AddPageActionConfiguration


type alias AddPageActionConfiguration =
    { name : String
    , additionalData : List AdditionalData.AdditionalData
    }


{-| Build Nreum AddPageAction with specific action name
-}
init : String -> AddPageAction
init name =
    AddPageAction (AddPageActionConfiguration name [])


{-| Add custom JSON data attributes to Nreum AddPageAction
-}
addAdditionalData : AdditionalData.AdditionalData -> AddPageAction -> AddPageAction
addAdditionalData additionalData (AddPageAction pageAction) =
    AddPageAction { pageAction | additionalData = additionalData :: pageAction.additionalData }


{-| Convert Nreum AddPageAction to JSON
-}
encode : AddPageAction -> JE.Value
encode (AddPageAction pageAction) =
    JE.object
        [ ( "actionName", JE.string pageAction.name )
        , ( "additionalData", encodeAdditionalData pageAction )
        , ( "type_", JE.string "page_action" )
        ]


{-| Convert custom attributes of Nreum AddPageAction to JSON
-}
encodeAdditionalData : AddPageActionConfiguration -> JE.Value
encodeAdditionalData { additionalDataList } =
    JE.object
        (additionalDataList |> List.map (\data -> AdditionalData.encode data))

module NewRelic.NREUM.PageAction exposing
    ( PageAction
    , init
    , withPageUrl, withAdditionalData
    , encode
    )

{-| Reports a browser PageAction event to New Relic One along with a name and optional attributes.
This API call sends a browser PageAction event with your user-defined name and optional attributes to dashboards, along with several default attributes.
This is useful to track any event that is not already tracked automatically by the browser agent, such as clicking a Subscribe button or accessing a tutorial.


## Configuration

@docs PageAction


## Configuration Methods

@docs init


## Overlay Configuration

@docs withPageUrl, withAdditionalData


## Encoding

@docs encode

-}

import Json.Encode as JE


type PageAction
    = PageAction PageActionConfiguration


type alias PageActionConfiguration =
    { name : String
    , pageUrl : Maybe String
    , additionalData : List AdditionalData
    }


type alias AdditionalData =
    { key : String
    , value : String
    }


{-| Build Nreum PageAction with specific action name
-}
init : String -> PageAction
init name =
    PageAction (PageActionConfiguration name Nothing [])


{-| Add specific URL to Nreum PageAction
-}
withPageUrl : String -> PageAction -> PageAction
withPageUrl pageUrl (PageAction pageAction) =
    PageAction { pageAction | pageUrl = Just pageUrl }


{-| Add custom JSON data attributes to Nreum PageAction
-}
withAdditionalData : String -> String -> PageAction -> PageAction
withAdditionalData key value (PageAction pageAction) =
    PageAction { pageAction | additionalData = AdditionalData key value :: pageAction.additionalData }


{-| Convert Nreum PageAction to JSON
-}
encode : PageAction -> JE.Value
encode (PageAction config) =
    JE.object
        [ ( "name", JE.string config.name )
        , ( "attributes", encodeAttributes config )
        ]


{-| Convert custom attributes of Nreum PageAction to JSON
-}
encodeAttributes : PageActionConfiguration -> JE.Value
encodeAttributes { pageUrl, additionalData } =
    JE.object
        ((additionalData |> List.map (\data -> ( data.key, JE.string data.value )))
            ++ appendMaybe pageUrl encodePageUrl
        )


encodePageUrl : String -> List ( String, JE.Value )
encodePageUrl pageUrl =
    [ ( "route", JE.string pageUrl ) ]


appendMaybe : Maybe a -> (a -> List b) -> List b
appendMaybe maybe mapper =
    maybe
        |> Maybe.map mapper
        |> Maybe.withDefault []

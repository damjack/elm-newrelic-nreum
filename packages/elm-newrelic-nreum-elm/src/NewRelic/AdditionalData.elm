module NewRelic.AdditionalData exposing
    ( AdditionalData, DataValue
    , setBool, setFloat, setInt, setString
    , encode
    )

{-|


## Configuration

@docs AdditionalData, DataValue


## Configuration Methods

@docs setBool, setFloat, setInt, setString


## Encoding

@docs encode

-}

import Json.Encode as JE


type AdditionalData
    = AdditionalData AdditionalDataConfig


type alias AdditionalDataConfig =
    { key : String
    , value : DataValue
    }


type DataValue
    = DataValueString String
    | DataValueInt Int
    | DataValueBool Bool
    | DataValueFloat Float


setString : String -> String -> AdditionalData
setString key value =
    AdditionalData (AdditionalDataConfig key (DataValueString value))


setInt : String -> Int -> AdditionalData
setInt key value =
    AdditionalData (AdditionalDataConfig key (DataValueInt value))


setBool : String -> Bool -> AdditionalData
setBool key value =
    AdditionalData (AdditionalDataConfig key (DataValueBool value))


setFloat : String -> Float -> AdditionalData
setFloat key value =
    AdditionalData (AdditionalDataConfig key (DataValueFloat value))


encode : AdditionalData -> ( String, JE.Value )
encode (AdditionalData dataConfig) =
    case dataConfig.value of
        DataValueString string ->
            ( dataConfig.key, JE.string string )

        DataValueInt int ->
            ( dataConfig.key, JE.int int )

        DataValueBool bool ->
            ( dataConfig.key, JE.bool bool )

        DataValueFloat float ->
            ( dataConfig.key, JE.float float )

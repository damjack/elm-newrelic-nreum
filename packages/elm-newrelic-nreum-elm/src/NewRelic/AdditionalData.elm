module NewRelic.AdditionalData exposing (AdditionalData, DataValue, encode, setBool, setFloat, setInt, setString)

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
    AdditionalDataString (AdditionalDataStringConfig key value)


setInt : String -> Int -> AdditionalData
setInt key value =
    AdditionalDataInt (AdditionalDataIntConfig key value)


setBool : String -> Bool -> AdditionalData
setBool key value =
    AdditionalDataBool (AdditionalDataBoolConfig key value)


setFloat : String -> Float -> AdditionalData
setFloat key value =
    AdditionalDataFloat (AdditionalDataFloatConfig key value)


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

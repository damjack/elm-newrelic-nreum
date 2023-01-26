module NewRelic.NREUM.NoticeError exposing
    ( NoticeError
    , init
    , toGraphQLError, toGraphQLHttpError, toGraphQLResultError, toHttpError, toRemoteDataError
    , encode
    )

{-| Identifies a browser error without disrupting your app's operations.
Use this call to notice or log your app's handled or other miscellaneous errors.
This is useful when you have caught and handled an error, but you still want to identify it without disrupting your app's operation.


## Configuration

@docs NoticeError


## Configuration Methods

@docs init


## Overlay Configuration

@docs withPageUrl


## Helpers

@docs toGraphQLError, toGraphQLHttpError, toGraphQLResultError, toHttpError, toRemoteDataError


## Encoding

@docs encode

-}

import Graphql.Http
import Graphql.Http.GraphqlError as GraphqlError
import Http
import Json.Decode as JD
import Json.Encode as JE
import NewRelic.AdditionalData as AdditionalData
import RemoteData exposing (RemoteData(..))


type NoticeError
    = NoticeError NoticeErrorConfiguration


type alias NoticeErrorConfiguration =
    { prefix : String
    , stackTrace : String
    , additionalData : List AdditionalData.AdditionalData
    }


{-| Build Nreum NoticeError with specific action name
-}
init : String -> String -> NoticeError
init prefix stackTrace =
    NoticeError (NoticeErrorConfiguration prefix stackTrace [])


{-| Add custom attribute to Nreum Interaction
-}
addAdditionalData : AdditionalData.AdditionalData -> Interaction -> Interaction
addAdditionalData additionalData (NoticeError noticeError) =
    Interaction { noticeError | additionalData = additionalData :: noticeError.additionalData }


{-| Convert Nreum NoticeError to JSON
-}
encode : NoticeError -> JE.Value
encode (NoticeError noticeError) =
    JE.object
        [ ( "errorPrefix", JE.string noticeError.prefix )
        , ( "errorStackTrace", JE.string noticeError.stackTrace )
        , ( "additionalData", encodeAdditionalData noticeError )
        , ( "type_", JE.string "notice_error" )
        ]


{-| Convert custom attributes of Nreum NoticeError to JSON
-}
encodeAdditionalData : AddPageActionConfiguration -> JE.Value
encodeAdditionalData { additionalDataList } =
    JE.object
        (additionalDataList |> List.map (\data -> AdditionalData.encode data))


toHttpError : Http.Error -> String
toHttpError err =
    case err of
        Http.BadUrl error ->
            "Bad url " ++ error

        Http.Timeout ->
            "Request timeout"

        Http.NetworkError ->
            "Network error"

        Http.BadStatus response ->
            "Bad Status: " ++ String.fromInt response

        Http.BadBody error ->
            error


toGraphQLResultError : Graphql.Http.Error result -> String
toGraphQLResultError error =
    case error of
        Graphql.Http.GraphqlError _ graphqlErrorList ->
            "GraphqlError " ++ (List.map toGraphQLError graphqlErrorList |> String.join "- ")

        Graphql.Http.HttpError httpError ->
            toGraphQLHttpError httpError


toGraphQLError : GraphqlError.GraphqlError -> String
toGraphQLError graphqlError =
    graphqlError.message


toGraphQLHttpError : Graphql.Http.HttpError -> String
toGraphQLHttpError httpError =
    case httpError of
        Graphql.Http.BadUrl error ->
            "Bad url " ++ error

        Graphql.Http.Timeout ->
            "Request timeout"

        Graphql.Http.NetworkError ->
            "Network error"

        Graphql.Http.BadStatus _ response ->
            "Bad Status: " ++ response

        Graphql.Http.BadPayload error ->
            JD.errorToString error


toRemoteDataError : RemoteData (Graphql.Http.Error response) response -> String
toRemoteDataError remoteData =
    case remoteData of
        Failure error ->
            toGraphQLResultError error

        _ ->
            ""

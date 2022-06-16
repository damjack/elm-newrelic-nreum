module NewRelic.NREUM.NoticeError exposing
    ( NoticeError
    , init
    , withPageUrl
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
import RemoteData exposing (RemoteData(..))


type NoticeError
    = NoticeError NoticeErrorConfiguration


type alias NoticeErrorConfiguration =
    { message : String
    , error : String
    , pageUrl : Maybe String
    }


{-| Build Nreum NoticeError with specific action name
-}
init : String -> String -> NoticeError
init message error =
    NoticeError (NoticeErrorConfiguration message error Nothing)


{-| Add specific URL to Nreum NoticeError
-}
withPageUrl : String -> NoticeError -> NoticeError
withPageUrl pageUrl (NoticeError noticeError) =
    NoticeError { noticeError | pageUrl = Just pageUrl }


{-| Convert Nreum NoticeError to JSON
-}
encode : NoticeError -> JE.Value
encode (NoticeError config) =
    JE.object
        ([ ( "message", JE.string config.message )
         , ( "error", JE.string config.error )
         ]
            ++ appendMaybe config.pageUrl encodePageUrl
        )


encodePageUrl : String -> List ( String, JE.Value )
encodePageUrl pageUrl =
    [ ( "route", JE.string pageUrl ) ]


appendMaybe : Maybe a -> (a -> List b) -> List b
appendMaybe maybe mapper =
    maybe
        |> Maybe.map mapper
        |> Maybe.withDefault []


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

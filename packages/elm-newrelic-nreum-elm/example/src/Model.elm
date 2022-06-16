module Model exposing (..)

import Api
import Graphql.Http
import NewRelic.NREUM.NoticeError as NRNoticeError
import NewRelicNreum as NRNreum
import RemoteData exposing (RemoteData)
import TrackingPorts


type Msg
    = Init
    | LoadQuery
    | GotQuery (RemoteData (Graphql.Http.Error Api.Response) Api.Response)
    | LoadHttp
    | Click String


type alias Flags =
    { apiUrl : String }


type alias Model =
    { flags : Flags
    , result : Maybe Api.Response
    }


init : Flags -> Model
init flags =
    Model flags Nothing


loadQuery : Model -> Cmd Msg
loadQuery { flags } =
    Api.allFilmsQuery
        |> Graphql.Http.queryRequest flags.apiUrl
        |> Graphql.Http.send (RemoteData.fromResult >> GotQuery)


updateModel : Model -> RemoteData (Graphql.Http.Error Api.Response) Api.Response -> ( Model, Cmd Msg )
updateModel model response =
    case response of
        RemoteData.Success result ->
            ( { model | result = Just result }, Cmd.none )

        RemoteData.Failure err ->
            ( model
            , err
                |> NRNoticeError.toGraphQLResultError
                |> NRNoticeError.init "error @requestResult"
                |> NRNoticeError.withPageUrl "/home"
                |> NRNreum.noticeError
                |> NRNreum.publish TrackingPorts.trackNoticeError
            )

        _ ->
            ( model, Cmd.none )

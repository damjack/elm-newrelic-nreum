module Main exposing (init, main, update, view)

import Api
import Browser
import Browser.Navigation exposing (Key)
import Html exposing (Html)
import Html.Attributes as Attrs
import Html.Events as Events
import Model as M exposing (Flags, Model, Msg(..))
import NewRelic.NREUM.Interaction as NRInteraction
import NewRelicNreum as NRNreum
import NewRelic.NREUM.Release as NRRelease
import Task
import TrackingPorts


main : Program Flags Model Msg
main =
    Browser.document
        { view = view
        , init = init
        , update = update
        , subscriptions = always Sub.none
        }


init : Flags -> ( Model, Cmd Msg )
init flags =
    ( M.init flags, Init |> Task.succeed |> Task.perform identity )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Init ->
            ( model
            , Cmd.batch
                [ NRRelease.init "App Name" "V-0.0.1"
                    |> NRNreum.release
                    |> NRNreum.publish TrackingPorts.trackRelease
                , LoadQuery |> Task.succeed |> Task.perform identity
                ]
            )

        LoadQuery ->
            ( model, M.loadQuery model )

        GotQuery response ->
            M.updateModel model response

        LoadHttp ->
            ( model, Cmd.none )

        Click name ->
            ( model
            , NRInteraction.init "click @button"
                |> NRInteraction.withActionText "click"
                |> NRInteraction.withSetAttribute "name" name
                |> NRNreum.interaction
                |> NRNreum.publish TrackingPorts.trackInteraction
            )


view : Model -> Browser.Document Msg
view model =
    Browser.Document "Test" (viewBody model)


viewBody : Model -> List (Html Msg)
viewBody model =
    [ Html.header [ Attrs.class "col-lg-8 mx-auto p-3 py-md-5" ]
        [ Html.div [ Attrs.class "d-flex align-items-center pb-3 mb-5" ]
            [ Html.span [ Attrs.class "fs-4" ] [ Html.text "App" ]
            , Html.button [ Attrs.class "btn btn-primary", Events.onClick M.Init ] [ Html.text "Reload" ]
            ]
        ]
    , Html.main_ [ Attrs.class "container" ]
        [ Html.div [ Attrs.class "row row-cols-1 row-cols-sm-2 row-cols-md-4 g-3" ]
            (model.result
                |> Maybe.map .allFilms
                |> Maybe.map .films
                |> Maybe.map (List.map films)
                |> Maybe.withDefault []
            )
        ]
    ]


films : Api.FilmResult -> Html Msg
films film =
    Html.div [ Attrs.class "col" ]
        [ Html.div [ Attrs.class "card shadow-sm" ]
            [ Html.img [ Attrs.src "https://via.placeholder.com/150" ] []
            , Html.div [ Attrs.class "card-body" ]
                [ Html.h5 [ Attrs.class "card-title" ] [ Html.text film.title ]
                , Html.p [ Attrs.class "card-text" ] [ Html.text film.openingCrawl ]
                , Html.button [ Attrs.class "btn btn-primary", Events.onClick (M.Click film.title) ] [ Html.text "click" ]
                ]
            ]
        ]

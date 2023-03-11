module Api exposing (..)

import Api.Object exposing (Film, FilmsConnection)
import Api.Object.Film as FilmObject
import Api.Object.FilmsConnection as FilmsConnectionObject
import Api.Query as Query
import Graphql.Operation exposing (RootQuery)
import Graphql.OptionalArgument as OptionalArgument exposing (OptionalArgument(..))
import Graphql.SelectionSet as SS exposing (SelectionSet)


type alias Response =
    { allFilms : AllFilmsResult
    }


type alias AllFilmsResult =
    { films : List FilmResult
    , totalCount : Int
    }


type alias FilmResult =
    { title : String
    , episodeID : Int
    , openingCrawl : String
    }


allFilmsQuery : SelectionSet Response RootQuery
allFilmsQuery =
    let
        queryArgument defaultArgs =
            { defaultArgs | after = Absent, first = Absent, before = Absent, last = Absent }
    in
    SS.succeed Response
        |> SS.with (Query.allFilms queryArgument allFilmsQuerySelection |> SS.nonNullOrFail)


allFilmsQuerySelection : SelectionSet AllFilmsResult FilmsConnection
allFilmsQuerySelection =
    SS.succeed AllFilmsResult
        |> SS.with (FilmsConnectionObject.films filmsQuerySelection |> SS.nonNullOrFail |> SS.nonNullElementsOrFail)
        |> SS.with (FilmsConnectionObject.totalCount |> SS.map (Maybe.withDefault 0))


filmsQuerySelection : SelectionSet FilmResult Film
filmsQuerySelection =
    SS.succeed FilmResult
        |> SS.with (FilmObject.title |> SS.map (Maybe.withDefault ""))
        |> SS.with (FilmObject.episodeID |> SS.map (Maybe.withDefault 0))
        |> SS.with (FilmObject.openingCrawl |> SS.map (Maybe.withDefault ""))

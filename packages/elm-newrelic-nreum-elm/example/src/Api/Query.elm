-- Do not manually edit this file, it was auto-generated by dillonkearns/elm-graphql
-- https://github.com/dillonkearns/elm-graphql


module Api.Query exposing (..)

import Api.InputObject
import Api.Interface
import Api.Object
import Api.Scalar
import Api.ScalarCodecs
import Api.Union
import Graphql.Internal.Builder.Argument as Argument exposing (Argument)
import Graphql.Internal.Builder.Object as Object
import Graphql.Internal.Encode as Encode exposing (Value)
import Graphql.Operation exposing (RootMutation, RootQuery, RootSubscription)
import Graphql.OptionalArgument exposing (OptionalArgument(..))
import Graphql.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode exposing (Decoder)


type alias AllFilmsOptionalArguments =
    { after : OptionalArgument String
    , first : OptionalArgument Int
    , before : OptionalArgument String
    , last : OptionalArgument Int
    }


allFilms :
    (AllFilmsOptionalArguments -> AllFilmsOptionalArguments)
    -> SelectionSet decodesTo Api.Object.FilmsConnection
    -> SelectionSet (Maybe decodesTo) RootQuery
allFilms fillInOptionals____ object____ =
    let
        filledInOptionals____ =
            fillInOptionals____ { after = Absent, first = Absent, before = Absent, last = Absent }

        optionalArgs____ =
            [ Argument.optional "after" filledInOptionals____.after Encode.string, Argument.optional "first" filledInOptionals____.first Encode.int, Argument.optional "before" filledInOptionals____.before Encode.string, Argument.optional "last" filledInOptionals____.last Encode.int ]
                |> List.filterMap Basics.identity
    in
    Object.selectionForCompositeField "allFilms" optionalArgs____ object____ (Basics.identity >> Decode.nullable)


type alias FilmOptionalArguments =
    { id : OptionalArgument Api.ScalarCodecs.Id
    , filmID : OptionalArgument Api.ScalarCodecs.Id
    }


film :
    (FilmOptionalArguments -> FilmOptionalArguments)
    -> SelectionSet decodesTo Api.Object.Film
    -> SelectionSet (Maybe decodesTo) RootQuery
film fillInOptionals____ object____ =
    let
        filledInOptionals____ =
            fillInOptionals____ { id = Absent, filmID = Absent }

        optionalArgs____ =
            [ Argument.optional "id" filledInOptionals____.id (Api.ScalarCodecs.codecs |> Api.Scalar.unwrapEncoder .codecId), Argument.optional "filmID" filledInOptionals____.filmID (Api.ScalarCodecs.codecs |> Api.Scalar.unwrapEncoder .codecId) ]
                |> List.filterMap Basics.identity
    in
    Object.selectionForCompositeField "film" optionalArgs____ object____ (Basics.identity >> Decode.nullable)


type alias AllPeopleOptionalArguments =
    { after : OptionalArgument String
    , first : OptionalArgument Int
    , before : OptionalArgument String
    , last : OptionalArgument Int
    }


allPeople :
    (AllPeopleOptionalArguments -> AllPeopleOptionalArguments)
    -> SelectionSet decodesTo Api.Object.PeopleConnection
    -> SelectionSet (Maybe decodesTo) RootQuery
allPeople fillInOptionals____ object____ =
    let
        filledInOptionals____ =
            fillInOptionals____ { after = Absent, first = Absent, before = Absent, last = Absent }

        optionalArgs____ =
            [ Argument.optional "after" filledInOptionals____.after Encode.string, Argument.optional "first" filledInOptionals____.first Encode.int, Argument.optional "before" filledInOptionals____.before Encode.string, Argument.optional "last" filledInOptionals____.last Encode.int ]
                |> List.filterMap Basics.identity
    in
    Object.selectionForCompositeField "allPeople" optionalArgs____ object____ (Basics.identity >> Decode.nullable)


type alias PersonOptionalArguments =
    { id : OptionalArgument Api.ScalarCodecs.Id
    , personID : OptionalArgument Api.ScalarCodecs.Id
    }


person :
    (PersonOptionalArguments -> PersonOptionalArguments)
    -> SelectionSet decodesTo Api.Object.Person
    -> SelectionSet (Maybe decodesTo) RootQuery
person fillInOptionals____ object____ =
    let
        filledInOptionals____ =
            fillInOptionals____ { id = Absent, personID = Absent }

        optionalArgs____ =
            [ Argument.optional "id" filledInOptionals____.id (Api.ScalarCodecs.codecs |> Api.Scalar.unwrapEncoder .codecId), Argument.optional "personID" filledInOptionals____.personID (Api.ScalarCodecs.codecs |> Api.Scalar.unwrapEncoder .codecId) ]
                |> List.filterMap Basics.identity
    in
    Object.selectionForCompositeField "person" optionalArgs____ object____ (Basics.identity >> Decode.nullable)


type alias AllPlanetsOptionalArguments =
    { after : OptionalArgument String
    , first : OptionalArgument Int
    , before : OptionalArgument String
    , last : OptionalArgument Int
    }


allPlanets :
    (AllPlanetsOptionalArguments -> AllPlanetsOptionalArguments)
    -> SelectionSet decodesTo Api.Object.PlanetsConnection
    -> SelectionSet (Maybe decodesTo) RootQuery
allPlanets fillInOptionals____ object____ =
    let
        filledInOptionals____ =
            fillInOptionals____ { after = Absent, first = Absent, before = Absent, last = Absent }

        optionalArgs____ =
            [ Argument.optional "after" filledInOptionals____.after Encode.string, Argument.optional "first" filledInOptionals____.first Encode.int, Argument.optional "before" filledInOptionals____.before Encode.string, Argument.optional "last" filledInOptionals____.last Encode.int ]
                |> List.filterMap Basics.identity
    in
    Object.selectionForCompositeField "allPlanets" optionalArgs____ object____ (Basics.identity >> Decode.nullable)


type alias PlanetOptionalArguments =
    { id : OptionalArgument Api.ScalarCodecs.Id
    , planetID : OptionalArgument Api.ScalarCodecs.Id
    }


planet :
    (PlanetOptionalArguments -> PlanetOptionalArguments)
    -> SelectionSet decodesTo Api.Object.Planet
    -> SelectionSet (Maybe decodesTo) RootQuery
planet fillInOptionals____ object____ =
    let
        filledInOptionals____ =
            fillInOptionals____ { id = Absent, planetID = Absent }

        optionalArgs____ =
            [ Argument.optional "id" filledInOptionals____.id (Api.ScalarCodecs.codecs |> Api.Scalar.unwrapEncoder .codecId), Argument.optional "planetID" filledInOptionals____.planetID (Api.ScalarCodecs.codecs |> Api.Scalar.unwrapEncoder .codecId) ]
                |> List.filterMap Basics.identity
    in
    Object.selectionForCompositeField "planet" optionalArgs____ object____ (Basics.identity >> Decode.nullable)


type alias AllSpeciesOptionalArguments =
    { after : OptionalArgument String
    , first : OptionalArgument Int
    , before : OptionalArgument String
    , last : OptionalArgument Int
    }


allSpecies :
    (AllSpeciesOptionalArguments -> AllSpeciesOptionalArguments)
    -> SelectionSet decodesTo Api.Object.SpeciesConnection
    -> SelectionSet (Maybe decodesTo) RootQuery
allSpecies fillInOptionals____ object____ =
    let
        filledInOptionals____ =
            fillInOptionals____ { after = Absent, first = Absent, before = Absent, last = Absent }

        optionalArgs____ =
            [ Argument.optional "after" filledInOptionals____.after Encode.string, Argument.optional "first" filledInOptionals____.first Encode.int, Argument.optional "before" filledInOptionals____.before Encode.string, Argument.optional "last" filledInOptionals____.last Encode.int ]
                |> List.filterMap Basics.identity
    in
    Object.selectionForCompositeField "allSpecies" optionalArgs____ object____ (Basics.identity >> Decode.nullable)


type alias SpeciesOptionalArguments =
    { id : OptionalArgument Api.ScalarCodecs.Id
    , speciesID : OptionalArgument Api.ScalarCodecs.Id
    }


species :
    (SpeciesOptionalArguments -> SpeciesOptionalArguments)
    -> SelectionSet decodesTo Api.Object.Species
    -> SelectionSet (Maybe decodesTo) RootQuery
species fillInOptionals____ object____ =
    let
        filledInOptionals____ =
            fillInOptionals____ { id = Absent, speciesID = Absent }

        optionalArgs____ =
            [ Argument.optional "id" filledInOptionals____.id (Api.ScalarCodecs.codecs |> Api.Scalar.unwrapEncoder .codecId), Argument.optional "speciesID" filledInOptionals____.speciesID (Api.ScalarCodecs.codecs |> Api.Scalar.unwrapEncoder .codecId) ]
                |> List.filterMap Basics.identity
    in
    Object.selectionForCompositeField "species" optionalArgs____ object____ (Basics.identity >> Decode.nullable)


type alias AllStarshipsOptionalArguments =
    { after : OptionalArgument String
    , first : OptionalArgument Int
    , before : OptionalArgument String
    , last : OptionalArgument Int
    }


allStarships :
    (AllStarshipsOptionalArguments -> AllStarshipsOptionalArguments)
    -> SelectionSet decodesTo Api.Object.StarshipsConnection
    -> SelectionSet (Maybe decodesTo) RootQuery
allStarships fillInOptionals____ object____ =
    let
        filledInOptionals____ =
            fillInOptionals____ { after = Absent, first = Absent, before = Absent, last = Absent }

        optionalArgs____ =
            [ Argument.optional "after" filledInOptionals____.after Encode.string, Argument.optional "first" filledInOptionals____.first Encode.int, Argument.optional "before" filledInOptionals____.before Encode.string, Argument.optional "last" filledInOptionals____.last Encode.int ]
                |> List.filterMap Basics.identity
    in
    Object.selectionForCompositeField "allStarships" optionalArgs____ object____ (Basics.identity >> Decode.nullable)


type alias StarshipOptionalArguments =
    { id : OptionalArgument Api.ScalarCodecs.Id
    , starshipID : OptionalArgument Api.ScalarCodecs.Id
    }


starship :
    (StarshipOptionalArguments -> StarshipOptionalArguments)
    -> SelectionSet decodesTo Api.Object.Starship
    -> SelectionSet (Maybe decodesTo) RootQuery
starship fillInOptionals____ object____ =
    let
        filledInOptionals____ =
            fillInOptionals____ { id = Absent, starshipID = Absent }

        optionalArgs____ =
            [ Argument.optional "id" filledInOptionals____.id (Api.ScalarCodecs.codecs |> Api.Scalar.unwrapEncoder .codecId), Argument.optional "starshipID" filledInOptionals____.starshipID (Api.ScalarCodecs.codecs |> Api.Scalar.unwrapEncoder .codecId) ]
                |> List.filterMap Basics.identity
    in
    Object.selectionForCompositeField "starship" optionalArgs____ object____ (Basics.identity >> Decode.nullable)


type alias AllVehiclesOptionalArguments =
    { after : OptionalArgument String
    , first : OptionalArgument Int
    , before : OptionalArgument String
    , last : OptionalArgument Int
    }


allVehicles :
    (AllVehiclesOptionalArguments -> AllVehiclesOptionalArguments)
    -> SelectionSet decodesTo Api.Object.VehiclesConnection
    -> SelectionSet (Maybe decodesTo) RootQuery
allVehicles fillInOptionals____ object____ =
    let
        filledInOptionals____ =
            fillInOptionals____ { after = Absent, first = Absent, before = Absent, last = Absent }

        optionalArgs____ =
            [ Argument.optional "after" filledInOptionals____.after Encode.string, Argument.optional "first" filledInOptionals____.first Encode.int, Argument.optional "before" filledInOptionals____.before Encode.string, Argument.optional "last" filledInOptionals____.last Encode.int ]
                |> List.filterMap Basics.identity
    in
    Object.selectionForCompositeField "allVehicles" optionalArgs____ object____ (Basics.identity >> Decode.nullable)


type alias VehicleOptionalArguments =
    { id : OptionalArgument Api.ScalarCodecs.Id
    , vehicleID : OptionalArgument Api.ScalarCodecs.Id
    }


vehicle :
    (VehicleOptionalArguments -> VehicleOptionalArguments)
    -> SelectionSet decodesTo Api.Object.Vehicle
    -> SelectionSet (Maybe decodesTo) RootQuery
vehicle fillInOptionals____ object____ =
    let
        filledInOptionals____ =
            fillInOptionals____ { id = Absent, vehicleID = Absent }

        optionalArgs____ =
            [ Argument.optional "id" filledInOptionals____.id (Api.ScalarCodecs.codecs |> Api.Scalar.unwrapEncoder .codecId), Argument.optional "vehicleID" filledInOptionals____.vehicleID (Api.ScalarCodecs.codecs |> Api.Scalar.unwrapEncoder .codecId) ]
                |> List.filterMap Basics.identity
    in
    Object.selectionForCompositeField "vehicle" optionalArgs____ object____ (Basics.identity >> Decode.nullable)


type alias NodeRequiredArguments =
    { id : Api.ScalarCodecs.Id }


{-| Fetches an object given its ID

  - id - The ID of an object

-}
node :
    NodeRequiredArguments
    -> SelectionSet decodesTo Api.Interface.Node
    -> SelectionSet (Maybe decodesTo) RootQuery
node requiredArgs____ object____ =
    Object.selectionForCompositeField "node" [ Argument.required "id" requiredArgs____.id (Api.ScalarCodecs.codecs |> Api.Scalar.unwrapEncoder .codecId) ] object____ (Basics.identity >> Decode.nullable)
-- Do not manually edit this file, it was auto-generated by dillonkearns/elm-graphql
-- https://github.com/dillonkearns/elm-graphql
module Api.Object.SpeciesFilmsEdge exposing (..)

import Graphql.Internal.Builder.Argument as Argument exposing (Argument)
import Graphql.Internal.Builder.Object as Object
import Graphql.SelectionSet exposing (SelectionSet)
import Graphql.OptionalArgument exposing (OptionalArgument(..))
import Graphql.Operation exposing (RootMutation, RootQuery, RootSubscription)
import Api.Object
import Api.Interface
import Api.Union
import Api.Scalar
import Api.InputObject
import Api.ScalarCodecs
import Json.Decode as Decode
import Graphql.Internal.Encode as Encode exposing (Value)

{-| The item at the end of the edge
-}
node : SelectionSet decodesTo Api.Object.Film
 -> SelectionSet (Maybe decodesTo) Api.Object.SpeciesFilmsEdge
node object____ =
      Object.selectionForCompositeField "node" [] (object____) (Basics.identity >> Decode.nullable)


{-| A cursor for use in pagination
-}
cursor : SelectionSet String Api.Object.SpeciesFilmsEdge
cursor =
      Object.selectionForField "String" "cursor" [] (Decode.string)

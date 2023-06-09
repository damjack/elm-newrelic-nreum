-- Do not manually edit this file, it was auto-generated by dillonkearns/elm-graphql
-- https://github.com/dillonkearns/elm-graphql
module Api.Object.PageInfo exposing (..)

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

{-| When paginating forwards, are there more items?
-}
hasNextPage : SelectionSet Bool Api.Object.PageInfo
hasNextPage =
      Object.selectionForField "Bool" "hasNextPage" [] (Decode.bool)


{-| When paginating backwards, are there more items?
-}
hasPreviousPage : SelectionSet Bool Api.Object.PageInfo
hasPreviousPage =
      Object.selectionForField "Bool" "hasPreviousPage" [] (Decode.bool)


{-| When paginating backwards, the cursor to continue.
-}
startCursor : SelectionSet (Maybe String) Api.Object.PageInfo
startCursor =
      Object.selectionForField "(Maybe String)" "startCursor" [] (Decode.string |> Decode.nullable)


{-| When paginating forwards, the cursor to continue.
-}
endCursor : SelectionSet (Maybe String) Api.Object.PageInfo
endCursor =
      Object.selectionForField "(Maybe String)" "endCursor" [] (Decode.string |> Decode.nullable)

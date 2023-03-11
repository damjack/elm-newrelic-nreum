module NewRelic.NREUM.RouteName exposing
    ( RouteName
    , init
    , encode
    )

{-| Gives SPA routes more accurate names than default names. Monitors specific routes rather than by default grouping.
This method names the current route. This can be useful to:

  - Give routes more accurate names than they would have by default.
  - Monitor a route that might otherwise be grouped with other routes by default.


## Configuration

@docs RouteName


## Configuration Methods

@docs init


## Encoding

@docs encode

-}

import Json.Encode as JE


{-| RouteName type
-}
type RouteName
    = RouteName String


{-| Build Nreum RouteName with specific route page name
-}
init : String -> RouteName
init routeName =
    RouteName routeName


{-| Convert Nreum RouteName to JSON
-}
encode : RouteName -> JE.Value
encode (RouteName routeName) =
    JE.object
        [ ( "routeName", JE.string routeName )
        , ( "type_", JE.string "route_name" )
        ]

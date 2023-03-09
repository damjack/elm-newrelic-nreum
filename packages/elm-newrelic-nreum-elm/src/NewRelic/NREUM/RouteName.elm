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


type RouteName
    = RouteName RouteNameConfiguration


type alias RouteNameConfiguration =
    { routeName : String
    }


init : String -> RouteName
init routeName =
    RouteName (RouteNameConfiguration routeName)


encode : RouteName -> JE.Value
encode (RouteName config) =
    JE.object
        [ ( "routeName", JE.string config.routeName )
        , ( "type_", JE.string "route_name" )
        ]

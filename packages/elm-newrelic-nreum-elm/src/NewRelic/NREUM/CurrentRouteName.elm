module NewRelic.NREUM.CurrentRouteName exposing
    ( CurrentRouteName
    , init
    , encode
    )

{-| Gives SPA routes more accurate names than default names. Monitors specific routes rather than by default grouping.
This method names the current route. This can be useful to:

  - Give routes more accurate names than they would have by default.
  - Monitor a route that might otherwise be grouped with other routes by default.


## Configuration

@docs CurrentRouteName


## Configuration Methods

@docs init


## Encoding

@docs encode

-}

import Json.Encode as JE


type CurrentRouteName
    = CurrentRouteName CurrentRouteNameConfiguration


type alias CurrentRouteNameConfiguration =
    { routeName : String
    }


init : String -> CurrentRouteName
init routeName =
    CurrentRouteName (CurrentRouteNameConfiguration routeName)


encode : CurrentRouteName -> JE.Value
encode (CurrentRouteName config) =
    JE.object
        [ ( "route", JE.string config.routeName )
        ]

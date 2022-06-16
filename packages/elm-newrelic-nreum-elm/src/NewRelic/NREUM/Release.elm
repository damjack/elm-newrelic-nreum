module NewRelic.NREUM.Release exposing
    ( Release
    , init
    , encode
    )

{-| Adds a unique name and ID to identify releases with multiple JavaScript bundles on the same page.
In browser monitoring, a release is a way to tag errors with information about what version of your application is currently running.
This is useful for sites where shared components are owned by different teams, or multiple applications are deployed independently but run on the same page.


## Configuration

@docs Release


## Configuration Methods

@docs init


## Encoding

@docs encode

-}

import Json.Encode as JE


type Release
    = Release ReleaseConfiguration


type alias ReleaseConfiguration =
    { releaseName : String
    , releaseId : String
    }


init : String -> String -> Release
init releaseName releaseId =
    Release (ReleaseConfiguration releaseName releaseId)


encode : Release -> JE.Value
encode (Release config) =
    JE.object
        [ ( "name", JE.string config.releaseName )
        , ( "id", JE.string config.releaseId )
        ]

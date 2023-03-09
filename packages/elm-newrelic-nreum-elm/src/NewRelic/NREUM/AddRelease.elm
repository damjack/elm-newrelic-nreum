module NewRelic.NREUM.AddRelease exposing
    ( AddRelease
    , init
    , encode
    )

{-| Adds a unique name and ID to identify releases with multiple JavaScript bundles on the same page.
In browser monitoring, a release is a way to tag errors with information about what version of your application is currently running.
This is useful for sites where shared components are owned by different teams, or multiple applications are deployed independently but run on the same page.


## Configuration

@docs AddRelease


## Configuration Methods

@docs init


## Encoding

@docs encode

-}

import Json.Encode as JE


type AddRelease
    = AddRelease AddReleaseConfiguration


type alias AddReleaseConfiguration =
    { releaseName : String
    , releaseVersion : String
    }


init : String -> String -> AddRelease
init releaseName releaseId =
    AddRelease (AddReleaseConfiguration releaseName releaseVersion)


encode : AddRelease -> JE.Value
encode (AddRelease config) =
    JE.object
        [ ( "releaseName", JE.string config.releaseName )
        , ( "releaseVersion", JE.string config.releaseVersion )
        , ( "type_", JE.string "release" )
        ]

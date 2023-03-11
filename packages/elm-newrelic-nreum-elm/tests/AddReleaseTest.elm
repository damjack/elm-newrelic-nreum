module AddReleaseTest exposing (suite)

import Expect
import Json.Encode as JE
import NewRelic.NREUM.AddRelease as NRAddRelease
import Test exposing (..)


suite : Test
suite =
    describe "NewRelic.NREUM.AddRelease test"
        [ test "Generate JSON Value for AddRelease"
            (\_ ->
                NRAddRelease.init "App" "1.0.0"
                    |> NRAddRelease.encode
                    |> Expect.equal encodeTest
            )
        ]


encodeTest : JE.Value
encodeTest =
    JE.object
        [ ( "releaseName", JE.string "App" )
        , ( "releaseVersion", JE.string "1.0.0" )
        , ( "type_", JE.string "release" )
        ]

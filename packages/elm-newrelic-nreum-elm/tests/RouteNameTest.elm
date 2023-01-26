module RouteNameTest exposing (suite)

import Expect
import Json.Encode as JE
import NewRelic.NREUM.RouteName as NRRouteName
import Test exposing (..)


suite : Test
suite =
    describe "NewRelic.NREUM.RouteName test"
        [ test "Generate JSON Value for RouteName"
            (\_ ->
                NRRouteName.init "route_name"
                    |> NRRouteName.encode
                    |> Expect.equal encodeTest
            )
        ]


encodeTest : JE.Value
encodeTest =
    JE.object
        [ ( "routeName", JE.string "route_name" )
        ]

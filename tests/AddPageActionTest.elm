module AddPageActionTest exposing (suite)

import Expect
import Json.Encode as JE
import NewRelic.AdditionalData as AdditionalData
import NewRelic.NREUM.AddPageAction as NRAddPageAction
import Test exposing (..)


suite : Test
suite =
    describe "NewRelic.NREUM.AddPageAction test"
        [ test "Generate JSON Value for AddPageAction"
            (\_ ->
                NRAddPageAction.init "Action Name"
                    |> NRAddPageAction.encode
                    |> Expect.equal encodeTest
            )
        , test "Generate JSON Value for AddPageAction with AdditionalData"
            (\_ ->
                let
                    additionalDataString : AdditionalData.AdditionalData
                    additionalDataString =
                        AdditionalData.setString "key" "value"
                in
                NRAddPageAction.init "Action Name"
                    |> NRAddPageAction.addAdditionalData additionalDataString
                    |> NRAddPageAction.encode
                    |> Expect.equal encodeTestWithAdditionalData
            )
        ]


encodeTest : JE.Value
encodeTest =
    JE.object
        [ ( "actionName", JE.string "Action Name" )
        , ( "additionalData", JE.object [] )
        , ( "type_", JE.string "page_action" )
        ]


encodeTestWithAdditionalData : JE.Value
encodeTestWithAdditionalData =
    JE.object
        [ ( "actionName", JE.string "Action Name" )
        , ( "additionalData", encodeTestAdditionalData )
        , ( "type_", JE.string "page_action" )
        ]


encodeTestAdditionalData : JE.Value
encodeTestAdditionalData =
    JE.object
        [ ( "key", JE.string "value" ) ]

port module TrackingPorts exposing
    ( trackCurrentRouteName
    , trackInteraction
    , trackNoticeError
    , trackPageAction
    , trackRelease
    )

import Json.Encode as JE


port trackCurrentRouteName : JE.Value -> Cmd msg


port trackInteraction : JE.Value -> Cmd msg


port trackNoticeError : JE.Value -> Cmd msg


port trackPageAction : JE.Value -> Cmd msg


port trackRelease : JE.Value -> Cmd msg

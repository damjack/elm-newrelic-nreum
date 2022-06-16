module NewRelicNreum exposing
    ( currentRouteName, interaction, noticeError, pageAction, release
    , publish
    )

{-| You can use browser agent and SPA API to monitor virtually anything that executes inside the browser.

SPA monitoring can help you:

  - Create faster, more responsive, highly interactive apps.
  - Monitor the throughput and performance that real users are experiencing.
  - Troubleshoot and resolve problems within the context of the page load.
  - Query and visualize the data to assist with business decisions.
  - Bring better apps to the marketplace more quickly


## Defining tracking

@docs currentRouteName, interaction, noticeError, pageAction, release


## Publishing

@docs publish, publishList

-}

import Json.Encode as JE
import NewRelic.NREUM.CurrentRouteName as CurrentRouteName
import NewRelic.NREUM.Interaction as Interaction
import NewRelic.NREUM.NoticeError as NoticeError
import NewRelic.NREUM.PageAction as PageAction
import NewRelic.NREUM.Release as Release


type NreumTracking
    = CurrentRouteNameTracking CurrentRouteName.CurrentRouteName
    | InteractionTracking Interaction.Interaction
    | NoticeErrorTracking NoticeError.NoticeError
    | PageActionTracking PageAction.PageAction
    | ReleaseTracking Release.Release


currentRouteName : CurrentRouteName.CurrentRouteName -> NreumTracking
currentRouteName config =
    CurrentRouteNameTracking config


interaction : Interaction.Interaction -> NreumTracking
interaction config =
    InteractionTracking config


noticeError : NoticeError.NoticeError -> NreumTracking
noticeError config =
    NoticeErrorTracking config


pageAction : PageAction.PageAction -> NreumTracking
pageAction config =
    PageActionTracking config


release : Release.Release -> NreumTracking
release config =
    ReleaseTracking config


publish : (JE.Value -> Cmd msg) -> NreumTracking -> Cmd msg
publish mapperCmd tracking =
    case tracking of
        CurrentRouteNameTracking config ->
            config
                |> CurrentRouteName.encode
                |> mapperCmd

        InteractionTracking config ->
            config
                |> Interaction.encode
                |> mapperCmd

        NoticeErrorTracking config ->
            config
                |> NoticeError.encode
                |> mapperCmd

        PageActionTracking config ->
            config
                |> PageAction.encode
                |> mapperCmd

        ReleaseTracking config ->
            config
                |> Release.encode
                |> mapperCmd

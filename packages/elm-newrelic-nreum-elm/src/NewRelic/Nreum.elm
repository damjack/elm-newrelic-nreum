module NewRelic.Nreum exposing
    ( interaction, noticeError
    , publish
    , addPageAction, addRelease, routeName
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
import NewRelic.NREUM.AddPageAction as AddPageAction
import NewRelic.NREUM.AddRelease as AddRelease
import NewRelic.NREUM.Interaction as Interaction
import NewRelic.NREUM.NoticeError as NoticeError
import NewRelic.NREUM.RouteName as RouteName


type NreumTracking
    = RouteNameTracking RouteName.RouteName
    | InteractionTracking Interaction.Interaction
    | NoticeErrorTracking NoticeError.NoticeError
    | AddPageActionTracking AddPageAction.AddPageAction
    | AddReleaseTracking AddRelease.AddRelease


routeName : RouteName.RouteName -> NreumTracking
routeName config =
    RouteNameTracking config


interaction : Interaction.Interaction -> NreumTracking
interaction config =
    InteractionTracking config


noticeError : NoticeError.NoticeError -> NreumTracking
noticeError config =
    NoticeErrorTracking config


addPageAction : AddPageAction.AddPageAction -> NreumTracking
addPageAction config =
    AddPageActionTracking config


addRelease : AddRelease.AddRelease -> NreumTracking
addRelease config =
    AddReleaseTracking config


publish : (JE.Value -> Cmd msg) -> NreumTracking -> Cmd msg
publish mapperCmd tracking =
    case tracking of
        RouteNameTracking config ->
            config
                |> RouteName.encode
                |> mapperCmd

        InteractionTracking config ->
            config
                |> Interaction.encode
                |> mapperCmd

        NoticeErrorTracking config ->
            config
                |> NoticeError.encode
                |> mapperCmd

        AddPageActionTracking config ->
            config
                |> AddPageAction.encode
                |> mapperCmd

        AddReleaseTracking config ->
            config
                |> AddRelease.encode
                |> mapperCmd

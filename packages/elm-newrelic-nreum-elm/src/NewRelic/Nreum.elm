module NewRelic.Nreum exposing
    ( Nreum
    , routeName, interaction, noticeError, addPageAction, addRelease
    , publish
    )

{-| You can use browser agent and SPA API to monitor virtually anything that executes inside the browser.

SPA monitoring can help you:

  - Create faster, more responsive, highly interactive apps.
  - Monitor the throughput and performance that real users are experiencing.
  - Troubleshoot and resolve problems within the context of the page load.
  - Query and visualize the data to assist with business decisions.
  - Bring better apps to the marketplace more quickly


## Definition types

@docs Nreum


## Defining tracking

@docs routeName, interaction, noticeError, addPageAction, addRelease


## Publishing

@docs publish

-}

import Json.Encode as JE
import NewRelic.NREUM.AddPageAction as AddPageAction
import NewRelic.NREUM.AddRelease as AddRelease
import NewRelic.NREUM.Interaction as Interaction
import NewRelic.NREUM.NoticeError as NoticeError
import NewRelic.NREUM.RouteName as RouteName


type Nreum
    = RouteNameNreum RouteName.RouteName
    | InteractionNreum Interaction.Interaction
    | NoticeErrorNreum NoticeError.NoticeError
    | AddPageActionNreum AddPageAction.AddPageAction
    | AddReleaseNreum AddRelease.AddRelease


routeName : RouteName.RouteName -> Nreum
routeName config =
    RouteNameNreum config


interaction : Interaction.Interaction -> NreumNreum
interaction config =
    InteractionNreum config


noticeError : NoticeError.NoticeError -> NreumNreum
noticeError config =
    NoticeErrorNreum config


addPageAction : AddPageAction.AddPageAction -> NreumNreum
addPageAction config =
    AddPageActionNreum config


addRelease : AddRelease.AddRelease -> NreumNreum
addRelease config =
    AddReleaseNreum config


publish : (JE.Value -> Cmd msg) -> NreumNreum -> Cmd msg
publish mapperCmd tracking =
    case tracking of
        RouteNameNreum config ->
            config
                |> RouteName.encode
                |> mapperCmd

        InteractionNreum config ->
            config
                |> Interaction.encode
                |> mapperCmd

        NoticeErrorNreum config ->
            config
                |> NoticeError.encode
                |> mapperCmd

        AddPageActionNreum config ->
            config
                |> AddPageAction.encode
                |> mapperCmd

        AddReleaseNreum config ->
            config
                |> AddRelease.encode
                |> mapperCmd

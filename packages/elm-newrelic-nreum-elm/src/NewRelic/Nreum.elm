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


{-| Nreum type
-}
type Nreum
    = RouteNameNreum RouteName.RouteName
    | InteractionNreum Interaction.Interaction
    | NoticeErrorNreum NoticeError.NoticeError
    | AddPageActionNreum AddPageAction.AddPageAction
    | AddReleaseNreum AddRelease.AddRelease


{-| Send to NewRelic the current custom route name

Examples:

    NewRelic.NREUM.RouteName.init "RouteName"
        |> Nreum.routeName
        |> Nreum.publish

-}
routeName : RouteName.RouteName -> Nreum
routeName config =
    RouteNameNreum config


{-| Send to NewRelic a custom interaction with additional data filterable

Examples:

    NewRelic.NREUM.Interaction.init "Custom Interaction"
        |> NewRelic.NREUM.Interaction.addMessage "Somenthing to send to add major information about intearction"
        |> Nreum.interaction
        |> Nreum.publish

-}
interaction : Interaction.Interaction -> Nreum
interaction config =
    InteractionNreum config


{-| Send to NewRelic a custom error message with additional data filterable

Examples:

    NewRelic.NREUM.NoticeError.toGraphQLResultError graphQLResultError
        |> NewRelic.NREUM.NoticeError.init "error @requestResult"
        |> Nreum.noticeError
        |> Nreum.publish

-}
noticeError : NoticeError.NoticeError -> Nreum
noticeError config =
    NoticeErrorNreum config


{-| Add global release version

Examples:

    NewRelic.NREUM.AddRelease.init "APP" "1.0.0"
        |> Nreum.addRelease
        |> Nreum.publish

-}
addPageAction : AddPageAction.AddPageAction -> Nreum
addPageAction config =
    AddPageActionNreum config


{-| Add global release version

Examples:

    NewRelic.NREUM.AddRelease.init "APP" "1.0.0"
        |> Nreum.addRelease
        |> Nreum.publish

-}
addRelease : AddRelease.AddRelease -> Nreum
addRelease config =
    AddReleaseNreum config


{-| Send a message to DataDog RUM
-}
publish : (JE.Value -> Cmd msg) -> Nreum -> Cmd msg
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

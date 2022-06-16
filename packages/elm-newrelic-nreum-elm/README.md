# NewRelic Utility

> Utilities to automate API data to NewRelic

This component is useful to create a list of Cmd msg to interact with Browser agent or SPA API

## Use cases

#### Release
```elm
import NewRelic.Nreum as NRNreum
import NewRelic.Release as NRRelease


NRRelease.init "App Name" "V-0.0.1"
    |> NRNreum.release
    |> NRNreum.publish
```

#### CurrentRouteName
```elm
import NewRelic.CurrentRouteName as NRCurrentRouteName
import NewRelic.Nreum as NRNreum

NRCurrentRouteName.init "/page-path/:object-id/something"
    |> NRNreum.currentRouteName
    |> NRNreum.publish
```

#### Interaction
```elm
import NewRelic.Interaction as NRInteraction
import NewRelic.Nreum as NRNreum

NRInteraction.init "interaction @smoething"
    |> NRInteraction.withActionText "click purchease"
    |> NRInteraction.withSetAttribute "orderId" "123"
    |> NRNreum.interaction
    |> NRNreum.publish
```

#### NoticeError
```elm
import NewRelic.NoticeError as NRNoticeError
import NewRelic.Nreum as NRNreum

let
    requestResult: Graphql.Http.Error QueryOrMutationResult
    requestResult = ...
in
requestResult
    |> NRNoticeError.toGraphQLResultError
    |> NRNoticeError.init "error @requestResult"
    |> NRNoticeError.withPageUrl "/page-path/:object-id/something"
    |> NRNreum.noticeError
    |> NRNreum.publish
```

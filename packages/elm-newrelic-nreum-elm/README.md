# NewRelic Browser Utility for NREUM

> Utilities to automate RUM data to NewRelic

This component is useful to create a list of Cmd msg to interact with Browser agent or SPA API

## Getting started

### Installation
Install the package in the normal way:
```bash
elm install damjack/elm-newrelic
```

### Connect your JS to Elm
You need to initialise the NewRelic NREUM windows object and expose correct ports.

```javascript
import * as  newrelicElm from 'elm-newrelic';

const elmApp = Elm.Main.init({
  node: document.getElementById('root'),
  flags: {},
});

newrelicElm.cspEvent();
newrelicElm.elmPortsToJS(elmApp);
```

After this you can create a specific ports (one for every single tracking event) and helper to covert all Return msg to Cmd msg.
```elm
port module NewrelicPorts exposing
    ( routeNamePort_
    , interactionPort_
    , noticeErrorPort_
    , addPageActionPort_
    , addReleasePort_
    )

import Json.Encode as JE


port routeNamePort_ : JE.Value -> Cmd msg


port interactionPort_ : JE.Value -> Cmd msg


port noticeErrorPort_ : JE.Value -> Cmd msg


port addPageActionPort_ : JE.Value -> Cmd msg


port addReleasePort_ : JE.Value -> Cmd msg
```

And finally use that port to emitt `Cmd msg`:

Instead of use multiple separate ports, you can pass always to one:

```javascript
import * as  newrelicElm from 'elm-newrelic';

const elmApp = Elm.Main.init({
  node: document.getElementById('root'),
  flags: {},
});

newrelicElm.cspEvent();
newrelicElm.elmUniquePortToJS(elmApp);
```

And create the unique port:
```elm
port module NewrelicPort exposing
  ( nreumPort_
  )

import Json.Encode as JE


port nreumPort_ : JE.Value -> Cmd msg
```


### Usage into ELM

#### AddRelease
```elm
import NewRelic.NREUM.AddRelease as NRAddRelease
import NewRelic.Nreum as NRNreum
import NewrelicPort


NRAddRelease.init "App Name" "V-0.0.1"
    |> NRNreum.release
    |> NRNreum.publish NewrelicPort.nreumPort_
```

#### RouteName
```elm
import NewRelic.NREUM.RouteName as NRRouteName
import NewRelic.Nreum as NRNreum
import NewrelicPort


NRRouteName.init "/page-path/:object-id/something"
    |> NRNreum.routeName
    |> NRNreum.publish NewrelicPort.nreumPort_
```

#### Interaction
```elm
import NewRelic.NREUM.Interaction as NRInteraction
import NewRelic.AdditionalData as NRAdditionalData
import NewRelic.Nreum as NRNreum
import NewrelicPort

let
    aditionalDataString: NRAdditionalData.AdditionalData
    aditionalDataString = NRAdditionalData.setString "keyString" "value"

    aditionalDataInt: NRAdditionalData.AdditionalData
    aditionalDataInt = NRAdditionalData.setInt "keyInt" 123
in
NRInteraction.init "interaction @smoething"
    |> NRInteraction.addMessage "click purchease"
    |> NRInteraction.addAdditionalData aditionalDataString
    |> NRInteraction.addAdditionalData aditionalDataInt
    |> NRNreum.interaction
    |> NRNreum.publish NewrelicPort.nreumPort_
```

#### NoticeError
```elm
import NewRelic.NREUM.NoticeError as NRNoticeError
import NewRelic.AdditionalData as NRAdditionalData
import NewRelic.Nreum as NRNreum
import NewrelicPort


let
    requestResult: Graphql.Http.Error QueryOrMutationResult
    requestResult = ...

    aditionalDataString: NRAdditionalData.AdditionalData
    aditionalDataString = NRAdditionalData.setString "keyString" "value"

    aditionalDataInt: NRAdditionalData.AdditionalData
    aditionalDataInt = NRAdditionalData.setInt "keyInt" 123
in
requestResult
    |> NRNoticeError.toGraphQLResultError
    |> NRNoticeError.init "error @requestResult"
    |> NRNoticeError.addAdditionalData aditionalDataString
    |> NRNoticeError.addAdditionalData aditionalDataInt
    |> NRNreum.noticeError
    |> NRNreum.publish NewrelicPort.nreumPort_
```

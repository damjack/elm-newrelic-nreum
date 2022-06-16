'use strict';

import { Elm } from './Main.elm';

let app = Elm.Main.init({
  node: document.getElementById('root'),
  flags: {
    apiUrl: "https://swapi-graphql.netlify.app/.netlify/functions/index",
  },
});

app.ports.trackRelease.subscribe((payload) => {
  console.log('trackRelease: ', payload);
});

app.ports.trackInteraction.subscribe((payload) => {
  console.log('trackInteraction: ', payload);
});

app.ports.trackNoticeError.subscribe((payload) => {
  console.log('trackErrorNotice: ', payload);
});

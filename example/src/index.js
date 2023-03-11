'use strict';

import { Elm } from './Main.elm';

let app = Elm.Main.init({
  node: document.getElementById('root'),
  flags: {
    apiUrl: "https://swapi-graphql.netlify.app/.netlify/functions/index",
  },
});

app.ports.nreumPort_.subscribe((payload) => {
  console.log('NREUMLog: ', payload);
});


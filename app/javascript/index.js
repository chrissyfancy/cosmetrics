import React from 'react';
import ReactDOM from 'react-dom';
import App from './src/App';

$(document).ready(function() {
  console.log("Hello from react")
  let reactApp = document.getElementById('react-app')
  if(reactApp) {
    ReactDOM.render(
      <App />
    );
  };
});

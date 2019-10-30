import React from 'react';
import ReactDOM from 'react-dom';
import './index.css';
import App from './App';
import * as serviceWorker from './serviceWorker';
// ReactDOM.render(<App />, document.getElementById('root'));
document.addEventListener('DOMContentLoaded', function () {
    ReactDOM.render(React.createElement(App, null), document.body.appendChild(document.createElement('div')));
});
// If you want your app to work offline and load faster, you can change
// unregister() to register() below. Note this comes with some pitfalls.
// Learn more about service workers: https://bit.ly/CRA-PWA
serviceWorker.unregister();
//# sourceMappingURL=index.js.map
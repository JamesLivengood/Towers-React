import React from 'react';
import RoutesContainer from './Routes';
import './App.css';

import { ApolloProvider } from '@apollo/react-hooks';
import ApolloClient from 'apollo-boost';

const client = new ApolloClient({
  uri: '/graphql',
});

const App: React.FC = () => {
  return (
    <ApolloProvider client={client}>
      <div className="App">
        <RoutesContainer />
      </div>
    </ApolloProvider>
  );
}

export default App;

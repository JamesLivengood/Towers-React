import React, { FC } from 'react';
import { gql } from 'apollo-boost';
import { useMutation } from '@apollo/react-hooks';

const UNSUBSCRIBE = gql`
  mutation Unsubscribe($id: ID!, $uk: String!) {
    unsubscribe(id: $id, unsubscribeKey: $uk) {
      id
      unsubscribedAt
    }
  }
`;

type IProps = {
    contactId: number,
    unsubscribeKey: string
    // callback: (success: boolean) => any # no need for callback b/c Apollo handles caching
};

const UnsubscribeButton: FC<IProps> = (props) => {
    const { contactId, unsubscribeKey } = props;
    const [unsubscribe] = useMutation(UNSUBSCRIBE);
    return (
        <button onClick={() => unsubscribe({variables: {id: contactId, uk: unsubscribeKey}})}>
            Unsubscribe
        </button>
    );
};

export { UnsubscribeButton };